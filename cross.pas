unit Cross; {Пересечения}

interface
    uses
        Functions; {Мат. функции}

    type
        coordinate_t = record
            x: double;
            y: double;
            g: fun_t;
            h: fun_t
        end;

    var
        coords: array [1..3] of coordinate_t;

    procedure Manage_root();

implementation
    uses
        SysUtils,  {Стандартное}
        Input,     {Обработка ввода}
        Output;    {Процесс вывода}

    {Метод бисекции}
    procedure Root(f, g: fun_t; a, b, eps_x: double; var x: double);
    var
        c: double;
    begin
        c := (a + b) / 2;
        Debug(FloatToStr(a) + ' ' + FloatToStr(b) + ' ' + FloatToStr(c));
        while b - a > eps_x do
        begin
            if ((f(a) - g(a)) * (f(c) - g(c)) < 0) then
                b := c
            else if ((f(c) - g(c)) * (f(b) - g(b)) < 0) then
                a := c
            else
                break;
            c := (a + b) / 2;
            Debug(FloatToStr(a) + ' ' + FloatToStr(b) + ' ' + FloatToStr(c))
        end;
        x := c
    end;

    procedure Manage_root();
    var
        i, j, k: byte;
        a, b: double;
        temp_coord: coordinate_t;
    begin
        Set_fun_arr();

        {Найти точки пересечения}
        Debug('Начало нахождения точек пересечений');
        k := 1;
        for i := 1 to 2 do
        begin 
            for j := (i+1) to 3 do
            begin 
                a := SECTIONS[k*2-1];
                b := SECTIONS[k*2];
                if a > b then
                    Write_err(ERR_BAD_SECTION, '');
                Debug('Нахождение точки пересечения: ' + IntToStr(k));
                Root(fun_arr.f[i], fun_arr.f[j],
                    a, b, eps_x, coords[k].x);
                coords[k].y := fun_arr.f[i](coords[k].x);
                coords[k].g := fun_arr.f[i]; {Первообразная первой мат. фун. пересечения}
                coords[k].h := fun_arr.f[j]; {Первообразная второй мат. фун. пересечения}
                inc(k)
            end;
        end;
        Debug('Конец нахождения точек пересечений');

        {Сортировка точек пересечений}
        Debug('Сортировка точек пересечений');
        for i := 1 to 2 do
        begin 
            for j := (i+1) to 3 do
            begin 
                if coords[i].x > coords[j].x then
                begin
                    temp_coord := coords[i];
                    coords[i] := coords[j];
                    coords[j] := temp_coord
                end;
            end;
        end;
    end;
end.
