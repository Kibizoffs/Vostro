unit Output; {Вывод}

interface
    procedure Prepare_output_file();
    procedure Debug(const msg: string);
    procedure Write_err(const msg_1: string; const msg_2: string);
    procedure Write_ans(const msg: string);


implementation
    uses
        Crt, SysUtils, {Стандартное}
        Global,        {Глобальное}
        Utils;         {Дополнительное}

    const
        LOG_PATH = 'vostro.log';
        TIME_SEPARATOR = ': ';

    procedure Prepare_output_file();
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
