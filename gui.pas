unit GUI; {Интерфейс}

interface
    procedure Launch_window();

implementation
    uses
        Math, PtcGraph, SysUtils, {Стандартное}
        Area,               {Площадь}
        Config,             {Конфигурация}
        Cross,              {Пересечения}
        Functions,          {Мат. функции}
        Output;             {Вывод}
        
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
end.
