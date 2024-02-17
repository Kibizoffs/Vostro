unit Area; {Площадь}

interface
    var
        s: double;

    procedure Manage_area();


implementation
    uses
        Math, SysUtils, {Стандартное}
        Cross,          {Пересечения}
        Functions,      {Мат. функции}
        Input,          {Ввод}
        Output;         {Вывод}
    
    function Integrate(f: fun_t; a, b: double; n: longint): double;
    var
        dif_x: double;
    begin
        dif_x := (b - a) / n;
        Integrate := (f(a) + f(b)) / 2;
        a += dif_x;
        while a < b do
        begin
            Integrate += f(a);
            a += dif_x
        end;
        Integrate *= dif_x
    end;

    function Integral(f: fun_t; a, b, eps_s: double): double;
    var
        dif_s: double;
        n: longint;
    begin
        dif_s := 1;
        n := 10;
        while dif_s > eps_s do
        begin
            dif_s := (abs(Integrate(f, a, b, n) - Integrate(f, a, b, 2*n))) / 3; {Правило Рунге}
            n *= 2
        end;
        Debug('n: ' + IntToStr(n));
        Integral := abs(Integrate(f, a, b, n))
    end;

    procedure Manage_area();
    var
        s1, s2: double;
    begin
        s := 0;
        Debug('Вычисление площади на 1-й области');
        Debug('Вычисление интеграла для 1-й первообразной');
        s1 := Integral(coords[1].g, coords[1].x, coords[2].x, eps_s);
        Debug('Вычисление интеграла для 2-й первообразной');
        s2 := Integral(coords[1].h, coords[1].x, coords[2].x, eps_s);
        s += abs(s1 - s2);
        Debug('Вычисление площади на 2-й области');
        Debug('Вычисление интеграла для 1-й первообразной');
        s1 := Integral(coords[3].g, coords[2].x, coords[3].x, eps_s);
        Debug('Вычисление интеграла для 2-й первообразной');
        s2 := Integral(coords[3].h, coords[2].x, coords[3].x, eps_s);
        s += abs(s1 - s2);

        Write_ans(
            fun_arr.s[1] + #10 +
            fun_arr.s[2] + #10 +
            fun_arr.s[3] + #10 +
            'x: ' + '(' + FloatToStr(coords[1].x) + ', ' + FloatToStr(coords[1].y) + ')' + #10 + 
            '   (' + FloatToStr(coords[2].x) + ', ' + FloatToStr(coords[2].y) + ')' + #10 + 
            '   (' + FloatToStr(coords[3].x) + ', ' + FloatToStr(coords[3].y) + ')' + #10 +
            's: ' + FloatToStr(s))
    end;
end.
