unit GUI; {Интерфейс}

interface
    procedure Load_GUI();

implementation
    uses
        Math, PtcGraph, SysUtils, {Стандартное}
        Area,                     {Площадь}
        Config,                   {Конфигурация}
        Cross,                    {Пересечения}
        Functions,                {Мат. функции}
        Input,                    {Ввод}
        Output;                   {Вывод}
        
    var
        mid_x, mid_y, offset, square: smallint;

    procedure Launch_window();
    var
        graph_driver, graph_mode: smallint;
    begin
        {freepascal.org/daily/packages/graph/ptcgraph}
        graph_driver := D4bit; {16 цветов}
        graph_mode := m1024x768; {Режим 1024*768px}
        InitGraph(graph_driver, graph_mode, '');
        if GraphResult <> grok then
            Write_err(ERR_NO_GRAPHICS, '');
    end;

    procedure Draw_lines();
    var
        i: smallint;
    begin
        SetColor(8);
        i := offset;
        while i <= GetMaxX do
        begin
            Line(i, 0, i, GetMaxY);
            if i <= GetMaxY then
                Line(0, i, GetMaxX, i);
            i += square
        end;
    end;

    procedure Draw_functions();
    var
        f: byte;
        x_px, y_px, y_px_old: smallint;
        x, y: double;
        colors: array[1..3] of byte = (4, 2, 1);
    begin
        stop_when_undef := false;

        for f := 1 to 3 do
        begin
            SetColor(colors[f]);
            x := -mid_x / square / scale;
            y := fun_arr.f[f](x);
            y_px_old := mid_y - Round(y * square * scale);
            for x_px := 1 to GetMaxX do
            begin
                x := (x_px - mid_x) / square / scale;
                y := fun_arr.f[f](x);
                y_px := mid_y - Round(y * square * scale);
                if abs(y_px_old - y_px) < GetMaxY then
                    Line(x_px - 1, y_px_old, x_px, y_px);
                y_px_old := y_px
            end
        end;
    end;

    procedure Fill_area();
    var
        x_px_min, x_px_max, x_px, y_px_min, y_px_max, y_px: smallint;
        x, y: double;
    begin
        x_px_min := Max(1, Round(coords[1].x * square * scale) + mid_x);
        x_px := x_px_min;
        x_px_max := Min(GetMaxX, Round(coords[3].x * square * scale) + mid_x);
        y_px_min := Max(1, Round(Min(coords[1].y, Min(coords[2].y, coords[3].y)) * square * scale) + mid_y);
        y_px := y_px_min;
        y_px_max := Min(GetMaxY, Round(Max(coords[1].y, Max(coords[2].y, coords[3].y)) * square * scale) + mid_y);
        while x_px < x_px_max do
        begin
            while y_px < y_px_max do
            begin
                x := (x_px - mid_x) / square / scale;
                y := (y_px - mid_y) / square / scale;
                if (x_px mod 4 = 0) and ((GetMaxY - y_px) mod 4 = 2) and Inside(x, y) then
                    PutPixel(x_px, GetMaxY - y_px, 10);
                inc(y_px)
            end;
            y_px := y_px_min;
            inc(x_px);
        end;
    end;

    procedure Draw_axes();
    begin
        SetColor(15);
        Line(0, mid_y, GetMaxX, mid_y); {Ось X}
        Line(mid_x, 0, mid_x, GetMaxY); {Ось Y}
    end;

    procedure Show_stats();
    var
        t_between: smallint;
    begin
        t_between := 22;

        SetFillStyle(SolidFill, 7);
        Bar(0, GetMaxY - t_between*7 - offset, 270, GetMaxY);

        SetTextStyle(DefaultFont, HorizDir, 2);
        SetColor(4);
        OutTextXY(offset, GetMaxY - t_between*7, fun_arr.s[1]);
        SetColor(2);
        OutTextXY(offset, GetMaxY - t_between*6, fun_arr.s[2]);
        SetColor(1);
        OutTextXY(offset, GetMaxY - t_between*5, fun_arr.s[3]);
        SetColor(5);
        OutTextXY(offset, GetMaxY - t_between*4, '(' + FloatToStr(RoundTo(coords[1].x, -4)) + ', ' + FloatToStr(RoundTo(coords[1].y, -4)) + ')');
        OutTextXY(offset, GetMaxY - t_between*3, '(' + FloatToStr(RoundTo(coords[2].x, -4)) + ', ' + FloatToStr(RoundTo(coords[2].y, -4)) + ')');
        OutTextXY(offset, GetMaxY - t_between*2, '(' + FloatToStr(RoundTo(coords[3].x, -4)) + ', ' + FloatToStr(RoundTo(coords[3].y, -4)) + ')');
        SetColor(10);
        OutTextXY(offset, GetMaxY - t_between*1, FloatToStr(s));
    end;

    procedure Load_GUI();
    begin
        Debug('Открывается окно');
        Launch_window();

        mid_x := GetMaxX div 2;
        mid_y := GetMaxY div 2;
        offset := 7;
        square := 63;

        SetBkColor(0);

        Debug('Рисуются линии');
        Draw_lines();

        Debug('Рисуются функции');
        Draw_functions();

        Debug('Заливается область');
        Fill_area();

        Debug('Рисуются оси');
        Draw_axes();

        Debug('Создаётся таблица');
        Show_stats();
    end;
end.
