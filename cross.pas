unit Cross; {Нахождение пересечений корней}

interface
    var
        crosses: array [1..3] of double;

    procedure Cross_finder();

implementation
    uses
        Input,     {Обработка ввода}
        Functions, {Функции}
        Output;    {Процесс вывода}

    function f4(i, j: byte; c: double): double;
    begin
        f4 := fun_arr[i](c) - fun_arr[j](c);
    end;

    procedure Cross_finder();
    var
        i, j, k: byte;
        a, b, c, y: double;
    begin
        Set_fun_arr();

        k := 1;
        for i := 1 to 2 do
        begin 
            for j := (i+1) to 3 do
            begin 
                a := sections[k*2-1];
                b := sections[k*2];
                c := (a + b) / 2;
                while b - a > eps_x do
                begin
                    if (f4(i, j, a) * f4(i, j, c) < 0) then
                        b := c
                    else if (f4(i, j, c) * f4(i, j, b) < 0) then
                        a := c
                    else
                        break;
                    c := (a + b) / 2
                end;
                crosses[k] := c;
                inc(k)
            end;
        end;
        WriteLn(crosses[1], crosses[2], crosses[3])
    end;
end.
