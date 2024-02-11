unit Cross; {Нахождение пересечений корней}

interface
    procedure Cross_finder();

implementation
    uses
        Functions; {Функции}

    procedure Cross_finder();
    begin
        writeln(f1(2), f2(2), f3(2))
    end;
end.
