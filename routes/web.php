<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/job', function (Request $request) {
    $name = $request->get('name');
    $sentence = $request->get('sentence');
    $fqcn = "App\\Jobs\\${name}Job";
    dispatch(new $fqcn($sentence));

    // list all queued jobs

});
