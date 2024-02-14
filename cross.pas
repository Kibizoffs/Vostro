unit Cross; {Пересечения}

interface
    uses
        Functions; {Мат. функции}

    type
        coordinate = record
            x: double;
            y: double;
            g: fun_type;
            h: fun_type
        end;

    var
        coords: array [1..3] of coordinate;

    procedure Manage_root();

implementation
    uses
        SysUtils,  {Стандартное}
        Input,     {Обработка ввода}
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
        temp_coord: coordinate;
    begin
        Set_fun_arr();

        {Найти точки пересечения}
        k := 1;
        for i := 1 to 2 do
        begin 
            for j := (i+1) to 3 do
            begin 
                a := SECTIONS[k*2-1];
                b := SECTIONS[k*2];
                if a > b then
                    Write_err(ERR_BAD_SECTION, '');
                Root(fun_arr.f[i], fun_arr.f[j],
                    a, b, eps_x, coords[k].x);
                coords[k].y := fun_arr.f[i](coords[k].x);
                coords[k].g := fun_arr.p[i];
                coords[k].h := fun_arr.p[j];
                inc(k)
            end;
        end;

        {Сортировка точек пересечений}
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
