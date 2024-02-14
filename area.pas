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
        
    function Integral(f: fun_type; a, b, eps_s: double): double;
    var
        n, i: longint;
    begin
        n := Ceil((b - a)/eps_s);
        integral := (f(a) + f(b))/2;
        for i := 1 to n - 1 do
            integral += f(a + i*eps_s);
        integral *= eps_s
    end;

    procedure Manage_area();
    var
        i: byte;
        s1, s2: double;
    begin
        s := 0;
        for i := 1 to 2 do
        begin
            s1 := abs(Integral(coords[i].g, coords[i].x, coords[i+1].x, eps_s));
            s2 := abs(Integral(coords[i].h, coords[i].x, coords[i+1].x, eps_s));
            s += abs(s1 - s2)
        end;

        Write_ans(
            fun_arr.s[1] + #10 +
            fun_arr.s[2] + #10 +
            fun_arr.s[3] + #10 +
            MSG_CROSSES + '(' + FloatToStr(coords[1].x) + ', ' + FloatToStr(coords[1].y) + ')' + #10 + 
            '   (' + FloatToStr(coords[2].x) + ', ' + FloatToStr(coords[2].y) + ')' + #10 + 
            '   (' + FloatToStr(coords[3].x) + ', ' + FloatToStr(coords[3].y) + ')' + #10 +
            MSG_AREA + FloatToStr(s))
    end;
end.
