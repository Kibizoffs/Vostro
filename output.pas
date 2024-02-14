unit Output; {Вывод}

interface
    const
        ERR_TOO_MANY_PARAMS = 'Слишком много параметров';
        ERR_BAD_PARAM = 'Плохой параметр: ';
        ERR_LOG_FILE = 'Возникла проблема с файлом журнала';
        ERR_BAD_SECTION = 'Плохой сегмент';
        ERR_BAD_NUM = 'Плохое число';
        ERR_NO_GRAPHICS = 'Возникла проблема с графикой';
        MSG_DEBUG = 'Отладка = ';
        MSG_LOG = 'Логирование = ';
        MSG_THEME = 'Тема = ';
        MSG_CROSSES = 'x: ';
        MSG_AREA = 's: ';

    var
        output_file: text;
        
    procedure Prepare_output_file();
    procedure Debug(const msg: string);
    procedure Write_err(const msg_1: string; const msg_2: string);
    procedure Write_ans(const msg: string);


implementation
    uses
        Crt, SysUtils, {Стандартное}
        Config;        {Конфигурация}

    const
        LOG_PATH = 'vostro.log';
        TIME_SEPARATOR = ': ';

    procedure Prepare_output_file();
    var
        err_code: byte;
    begin
        if not FileExists(LOG_PATH) then
            FileCreate(LOG_PATH);
        Assign(output_file, LOG_PATH);
        {$I-}
        Rewrite(output_file);
        err_code := IOResult;
        if err_code <> 0 then
        begin
            ini_log := false;
            Write_err(ERR_LOG_FILE, '')
        end;
        {$I+}
    end;

    procedure Write_output_file(const msg: string);
    var
        current_time: string;
    begin
        current_time := FormatDateTime('hh:nn:ss.zzz', Now);
        WriteLn(output_file, current_time + TIME_SEPARATOR + #10 + msg);
    end;

    procedure Debug(const msg: string);
    begin
        if ini_debug then
        begin
            TextColor(Magenta);
            WriteLn(msg);
            NormVideo();
        end;

        if ini_log then
            Write_output_file(msg);
    end;

    procedure Write_err(const msg_1: string; const msg_2: string);
    begin
        TextColor(red);
        WriteLn(msg_1 + msg_2);
        NormVideo();

        if ini_log then
        begin
            Write_output_file(msg_1 + msg_2);
            Close(output_file)
        end;

        Halt(1)
    end;

    procedure Write_ans(const msg: string);
    begin
        TextColor(green);
        WriteLn(msg);
        NormVideo();

        if ini_log then
            Write_output_file(msg);
    end;
end.
