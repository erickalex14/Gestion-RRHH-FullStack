<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{   

    //LOGIN
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required'
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['Las credenciales proporcionadas son incorrectas.'],
            ]);
        }

        // Crear token con el nombre del dispositivo
        $token = $user->createToken('auth_token')->plainTextToken;        // Cargar todas las relaciones necesarias para la verificación de admin
        $user->load([
            'employeeState',
            'employeeDetail.schedule',
            'employeeDetail.department',
            'employeeDetail.role',
            'employeeDetail.department.branch',
            'employeeDetail.department.branch.company'
        ]);

        return response()->json([
            'access_token' => $token,
            'token_type' => 'Bearer',
            'user' => $user
        ]);
    }

    public function logout(Request $request)
    {
        // Revocar el token actual
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Sesión cerrada exitosamente'
        ]);
    }

    public function me(Request $request)
    {
        // Obtener usuario autenticado con sus relaciones
        $user = $request->user()->load([
            'employeeState',
            'employeeDetail.schedule',
            'employeeDetail.department',
            'employeeDetail.role',
            'employeeDetail.department.branch',
            'employeeDetail.department.branch.company'
        ]);

        return response()->json([
            'user' => $user
        ]);
    }
}
