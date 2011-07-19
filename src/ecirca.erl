%% Copyright (C) 2011 by Alexander Pantyukhov <alwx.main@gmail.com>
%%                       Dmitry Groshev       <lambdadmitry@gmail.com>
%% Permission is hereby granted, free of charge, to any person obtaining a copy
%% of this software and associated documentation files (the "Software"), to deal
%% in the Software without restriction, including without limitation the rights
%% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
%% copies of the Software, and to permit persons to whom the Software is
%% furnished to do so, subject to the following conditions:

%% The above copyright notice and this permission notice shall be included in
%% all copies or substantial portions of the Software.

%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
%% THE SOFTWARE.

-module(ecirca).
-export([new/2,
         get/2, slice/3,
         set/3, update/3, push/2, push_many/3, push_list/2,
         max_slice/0, max_size/0, size/1,
         load/1, save/1]).

-export_types([res/0]).

-on_load(nif_init/0).

-define(STUB, not_loaded(?LINE)).
-define(APPNAME, ?MODULE).
-define(LIBNAME, ?MODULE).
-define(NULLVAL, 16#FFFFFFFFFFFFFFFF).

-type res()         :: <<>>.
-type nonneg()      :: non_neg_integer().
-type ecirca_type() :: last | max | min | sum | avg.

-spec new(pos_integer(), ecirca_type()) -> {ok, res()} |
                                           {error, max_size}.
new(_Size, _Type) -> ?STUB.

-spec set(res(), pos_integer(), nonneg()) -> {ok, res()} |
                                             {error, not_found}.
set(_Res, _I, _Val) -> ?STUB.

%% TODO
-spec update(res(), pos_integer(), nonneg()) -> {ok, res()} |
                                                {error, not_found}.
update(_Res, _I, _Val) -> ?STUB.

-spec push(res(), pos_integer()) -> {ok, res()}.
push(_Res, _Val) -> ?STUB.

%% TODO
-spec push_many(res(), nonneg(), nonneg()) -> {ok, res()}.
push_many(_Res, _N, _Val) -> ?STUB.

%% TODO
-spec push_list(res(), [nonneg()]) -> {ok, res()}.
push_list(_Res, _Lst) -> ?STUB.

-spec get(res(), pos_integer()) -> {ok, nonneg()} |
                                   {error, not_found}.
get(_Res, _I) -> ?STUB.

-spec slice(res(), pos_integer(), pos_integer()) -> [nonneg()] |
                                                    {error, slice_too_big}.
slice(_Res, _Start, _End) -> ?STUB.

-spec max_size() -> {ok, pos_integer()}.
max_size() -> ?STUB.

-spec max_slice() -> {ok, pos_integer()}.
max_slice() -> ?STUB.

-spec size(res()) -> {ok, pos_integer()}.
size(_Res) -> ?STUB.

%% TODO
-spec load(binary()) -> {ok, res()}.
load(_Bin) -> ?STUB.

%% TODO
-spec save(res()) -> {ok, binary()}.
save(_Res) -> ?STUB.

%% @doc Loads a NIF
-spec nif_init() -> ok | {error, _}.
nif_init() ->
    SoName = case code:priv_dir(?APPNAME) of
        {error, bad_name} ->
            case filelib:is_dir(filename:join(["..", priv])) of
                true ->
                    filename:join(["..", priv, ?MODULE]);
                _ ->
                    filename:join([priv, ?MODULE])
            end;
        Dir ->
            filename:join(Dir, ?MODULE)
    end,
    erlang:load_nif(SoName, 0).

not_loaded(Line) ->
    exit({not_loaded, [{module, ?MODULE}, {line, Line}]}).


