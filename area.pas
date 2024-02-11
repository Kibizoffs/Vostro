unit Area; {Площадь}

interface
        
    procedure Manage_area();


implementation
    uses
        Cross,     {Пересечения}
        Functions; {Мат. функции}

    procedure Order_fun(fun_arr: array of fun_type; a, b: coordinate);
    var
        c: double;
        i, j: byte;
        temp_fun: fun_type;
    begin
        c := (a.x + b.x) / 2;
        for i := 1 to 2 do
        begin 
            for j := (i+1) to 3 do
            begin 
                if fun_arr[i](c) > fun_arr[j](c) then
                begin
                    temp_fun := fun_arr[i];
                    fun_arr[i] := fun_arr[j];
                    fun_arr[j] := temp_fun
                end;
            end;
        end;
    end;
        
    function Integral(f: fun_type; a, b, eps_s: double): double;
    begin
        WriteLn('yo')
    end;

    procedure Manage_area();
    var
        fun_arr_copy: array[1..3] of fun_type;
        i: byte;
        s: double;
    begin
        s := 0;
        for i := 1 to 2 do
        begin
            fun_arr_copy := fun_arr;
            Order_fun(fun_arr_copy, crosses[i], crosses[i+1]);
            s := s {}
        end;

    end;
end.
