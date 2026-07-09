program PlayAudioBg;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.IOUtils,
  FMX.Media,
  Winapi.Windows; // Tambahkan ini untuk Windows API

var
  AudioPath: string;
  Player: TMediaPlayer;
  ConsoleWnd: HWND;
begin
  // Ambil handle jendela konsol aktif, lalu sembunyikan instan
  ConsoleWnd := GetConsoleWindow;
  if ConsoleWnd <> 0 then
    ShowWindow(ConsoleWnd, SW_HIDE);

  try
    AudioPath := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'audio.mp3');

    if TFile.Exists(AudioPath) then
    begin
      Player := TMediaPlayer.Create(nil);
      try
        Player.FileName := AudioPath;
        Player.Play;

        while Player.State = TMediaState.Playing do
        begin
          Sleep(100);
        end;
      finally
        Player.Free;
      end;
    end;
  except
    on E: Exception do
      ExitCode := 1;
  end;
end.
