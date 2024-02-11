unit GUI; {Графика}

interface
    procedure Launch_window();

implementation
    uses
        PtcGraph, SysUtils, {Стандартное}
        Cross,              {Нахождение пересечений корней}
        Output;             {Процесс вывода}
        
    var
        GraphDriver, GraphMode: integer;
        ch: char;

    procedure Launch_window();
    begin
        Debug('Driver: ' + IntToStr(GraphDriver) + '; Mode: ' + IntToStr(GraphMode));
        DetectGraph(GraphDriver, GraphMode);
        Debug('Driver: ' + IntToStr(GraphDriver) + '; Mode: ' + IntToStr(GraphMode));
        InitGraph(GraphDriver, GraphMode, '');

        Cross_finder();

        Read(ch);
        CloseGraph();
    end;
end.
