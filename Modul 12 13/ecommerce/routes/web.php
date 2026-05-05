<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\SiteController;

Route::get('/login', function () {
    if (Auth::check()) return redirect('/products');
    return view('login');
})->name('login');

Route::post('/login', [SiteController::class, 'auth']);

Route::get('/logout', function () {
    Auth::logout();
    return redirect('/login');
});

Route::resource('products', ProductController::class)->middleware('auth');