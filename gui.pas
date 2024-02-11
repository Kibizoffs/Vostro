unit GUI; {Интерфейс}

interface
    procedure Launch_window();
    procedure Draw();

implementation
    uses
        PtcGraph, SysUtils, {Стандартное}
        Output;             {Вывод}
        
    var
        {GraphDriver, GraphMode: byte;}
        ch: char;

    procedure Launch_window();
    begin
        {
        Debug('Driver: ' + IntToStr(GraphDriver) + '; Mode: ' + IntToStr(GraphMode));
        DetectGraph(GraphDriver, GraphMode);
        Debug('Driver: ' + IntToStr(GraphDriver) + '; Mode: ' + IntToStr(GraphMode));
        InitGraph(GraphDriver, GraphMode, '');
        }

        Read(ch);
        {
        CloseGraph();
        }
    end;

    procedure Draw();
    begin
        Read(ch);
    end;
end.
