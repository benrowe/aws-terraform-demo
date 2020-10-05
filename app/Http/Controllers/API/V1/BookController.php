<?php

declare(strict_types=1);

namespace App\Http\Controllers\API\V1;

use App\Http\Requests\StoreBookRequest;
use App\Http\Requests\UpdateBookRequest;
use App\Http\Resources\BookResource;
use App\Models\Book;

class BookController
{
    public function index()
    {
        return BookResource::collection(Book::all());
    }

    public function show(Book $book)
    {
        return new BookResource($book);
    }

    public function destroy(Book $book)
    {
        $book->delete();

        return new BookResource($book);
    }

    public function update(Book $book, UpdateBookRequest $request)
    {
        $book->fill($request->all());
        $book->save();

        return new BookResource($book);
    }

    public function store(Book $book, StoreBookRequest $request)
    {
        $book->fill($request->all());
        $book->save();

        return new BookResource($book);
    }
}
