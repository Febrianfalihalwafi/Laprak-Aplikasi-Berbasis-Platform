<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class SiteController extends Controller
{
    public function auth(Request $req)
    {
        if (Auth::attempt(['email' => $req->em, 'password' => $req->pwd])) {
            return redirect('/products');
        }
        return redirect('/login')->with('msg', 'Email / password salah');
    }
}