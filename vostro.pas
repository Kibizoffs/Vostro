Program Vostro;

uses
    Cthreads, {Стандартное (для работы PtcGraph)}
    Crt,      {Стандартное}
    Config,   {Конфигурация}
    Input,    {Ввод}
    Gui,      {Интерфейс}
    Cross,    {Пересечения}
    Area,     {Площадь}
    Output;   {Вывод}

begin
    {Терминал}
    ClrScr();
    NormVideo();

    Setup_ini(); {Конфигурация}

    Read_input(); {Ввод}

    Manage_root(); {Пересечения}

    Manage_area(); {Площадь}

    {Интерфейс}
    Launch_window();
    Draw();

    ReadLn();
end.
