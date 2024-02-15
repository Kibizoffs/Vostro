unit GUI; {Интерфейс}

interface
    procedure Launch_window();
    procedure Draw();

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
        graph_driver, graph_mode: smallint;
        i: integer;

    procedure Launch_window();
    begin
        {freepascal.org/daily/packages/graph/ptcgraph}
        graph_driver := D4bit; {16 цветов}
        graph_mode := m1024x768; {Режим 1024*768px}
        InitGraph(graph_driver, graph_mode, '');
        if GraphResult <> grok then
            Write_err(ERR_NO_GRAPHICS, '');

        SetBkColor(0);

        {Линии}
        SetColor(8);
        i := 8;
        while i <= 1024 do
        begin
            Line(i, 0, i, GetMaxY);
            if i <= 768 then
                Line(0, i, GetMaxX, i);
            i += 63
        end;

        {Оси}
        SetColor(15);
        Line(8 * 64, 0, 8 * 64, GetMaxY);
        Line(0, 8 * 48, GetMaxX, 8 * 48);

        SetFillStyle(SolidFill, 7);
        Bar(0, 620, 272, GetMaxY);

        SetTextStyle(DefaultFont, HorizDir, 2);
        SetColor(4);
        OutTextXY(8, 628, fun_arr.s[1]);
        SetColor(2);
        OutTextXY(8, 648, fun_arr.s[2]);
        SetColor(1);
        OutTextXY(8, 668, fun_arr.s[3]);
        SetColor(5);
        OutTextXY(8, 688, '(' + FloatToStr(RoundTo(coords[1].x, -4)) + ', ' + FloatToStr(RoundTo(coords[1].y, -4)) + ')');
        OutTextXY(8, 708, '(' + FloatToStr(RoundTo(coords[2].x, -4)) + ', ' + FloatToStr(RoundTo(coords[2].y, -4)) + ')');
        OutTextXY(8, 728, '(' + FloatToStr(RoundTo(coords[3].x, -4)) + ', ' + FloatToStr(RoundTo(coords[3].y, -4)) + ')');
        SetColor(10);
        OutTextXY(8, 748, FloatToStr(s));
    end;

    function Min(n1, n2, n3: double): double;
    begin
        if n1 > n2 then
            n1 := n2;
        if n1 > n3 then
            n1 := n3;
        Min := n1
    end;

    function Max(n1, n2, n3: double): double;
    begin
        if n1 < n2 then
            n1 := n2;
        if n1 < n3 then
            n1 := n3;
        Max := n1
    end;

    procedure Draw();
    var
        f: byte;
        x_px, y_px, x_px_min, x_px_max, y_px_min, y_px_max: smallint;
        x, y: double;
        colors: array[1..3] of byte = (4, 2, 1);
    begin
        stop_when_undef := false;

        for f := 1 to 3 do
            for x_px := 1 to 1024 do
            begin
                x := (x_px - 512) / 63 * scale;
                y := fun_arr.f[f](x);
                y_px := 386 - Round(y * 63);
                PutPixel(x_px, y_px, colors[f])
            end;

        x_px_min := Round(coords[1].x * 63 / scale) + 512;
        x_px_max := Round(coords[3].x * 63 / scale) + 512;
        x_px := x_px_min;
        y_px_min := Round(Min(coords[1].y, coords[2].y, coords[3].y) * 63 / scale) + 386;
        y_px_max := Round(Max(coords[1].y, coords[2].y, coords[3].y) * 63 / scale) + 386;
        y := y_px_min;
        while x_px < x_px_max do
        begin
            while y_px < y_px_max do
            begin
                x := (x_px - 512) / 63 * scale;
                SetColor(4);
                y := fun_arr.f[f](x);
                PutPixel(x_px, y_px, 10);
                inc(y_px);
                writeln(x_px_min, ' ', x_px_max, ' ', x_px, ' ', y_px);
            end;
            y_px := y_px_min;
            inc(x_px);
        end;
    end;
end.
