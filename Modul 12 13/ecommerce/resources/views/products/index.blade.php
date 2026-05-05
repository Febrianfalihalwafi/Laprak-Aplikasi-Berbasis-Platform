@extends('template')
@section('title', 'Daftar Produk')

@section('content')
<div class="col-md-10">
    @if(session('success'))
        <div class="alert alert-success">{{ session('success') }}</div>
    @endif
    <div class="d-flex justify-content-between align-items-center mb-3">
        <span>{{ session('msg') }}</span>
        <a href="{{ route('products.create') }}" class="btn btn-primary">Tambah</a>
    </div>
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th>Nama</th>
                <th>Harga</th>
                <th>Variant</th>
                <th>Aksi</th>
            </tr>
        </thead>
        <tbody>
            @foreach($products as $product)
            <tr>
                <td>{{ $product->name }}</td>
                <td>{{ $product->price }}</td>
                <td>
                    <ul>
                        @foreach($product->variants()->get() as $var)
                        <li>
                            <strong>{{ $var->name }}</strong><br>
                            Desc: {{ $var->description }}<br>
                            Proc: {{ $var->processor }}<br>
                            RAM: {{ $var->memory }}<br>
                            Strg: {{ $var->storage }}<br>
                            Product: {{ $var->product->name }}
                        </li>
                        @endforeach
                    </ul>
                </td>
                <td align="center">
                    <a href="{{ route('products.edit', $product->id) }}" class="btn btn-sm btn-primary">Edit</a>
                    <form method="POST" action="{{ route('products.destroy', $product->id) }}" style="display:inline" onsubmit="return confirm('Yakin hapus?')">
                        @csrf
                        @method('DELETE')
                        <button class="btn btn-sm btn-danger">Hapus</button>
                    </form>
                </td>
            </tr>
            @endforeach
        </tbody>
    </table>
</div>
@endsection