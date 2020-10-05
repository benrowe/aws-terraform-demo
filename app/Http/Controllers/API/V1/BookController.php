<?php

declare(strict_types=1);

namespace App\Http\Controllers\API\V1;

use App\Http\Resources\BookResource;
use App\Models\Book;

class BookController
{
    public function index()
    {
        return BookResource::collection(Book::all());
    }
}
