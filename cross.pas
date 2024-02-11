unit Cross; {Пересечения}

interface
    type
        coordinate = record
            x: double;
            y: double;
        end;

    var
        crosses: array [1..3] of coordinate;

    procedure Manage_root();

implementation
    uses
        SysUtils,  {Стандартное}
        Global,    {Глобальное}
        Input,     {Обработка ввода}
        Functions, {Функции}
        Output;    {Процесс вывода}

    {Метод бисекции}
    procedure Root(f, g: fun_type; a, b, eps_x: double; var x: double);
    var
        c: double;
    begin
        c := (a + b) / 2;
        while b - a > eps_x do
        begin
            if ((f(a) - g(a)) * (f(c) - g(c)) < 0) then
                b := c
            else if ((f(c) - g(c)) * (f(b) - g(b)) < 0) then
                a := c
            else
                break;
            c := (a + b) / 2
        end;
        x := c
    end;

    procedure Manage_root();
    var
        i, j, k: byte;
        a, b: double;
    begin
        Set_fun_arr();

        k := 1;
        for i := 1 to 2 do
        begin 
            for j := (i+1) to 3 do
            begin 
                a := sections[k*2-1];
                b := sections[k*2];
                if a > b then
                    Write_err(ERR_BAD_SECTION, '');
                Root(fun_arr[i], fun_arr[j],
                    a, b, eps_x, crosses[k].x);
                crosses[k].y := fun_arr[i](crosses[k].x);
                inc(k)
            end;
        end;

        Debug(
            MSG_CROSSES + #10 +
            '(' + FloatToStr(crosses[1].x) + ', ' + FloatToStr(crosses[1].y) + #10 +
            '(' + FloatToStr(crosses[2].x) + ', ' + FloatToStr(crosses[2].y) + #10 +
            '(' + FloatToStr(crosses[3].x) + ', ' + FloatToStr(crosses[3].y));
    end;
end.
