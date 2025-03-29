unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, TAGraph,
  TASeries, TARadialSeries;

type

  { TVisualizer }

  TVisualizer = class(TForm)
    Chart: TChart;
    ArrDisp: TBarSeries;
    StartButton: TButton;
    Generate: TButton;
    AlgList: TRadioGroup;
    DimArray: TTrackBar;
    procedure GenerateClick(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);

  private

  public

  end;

var
  Visualizer: TVisualizer;
  arr: array of Double;

implementation

{$R *.lfm}

{ TVisualizer }

procedure updateChart(var a:TBarSeries);
begin
  a.Clear;
  a.AddArray(arr);
  Visualizer.Refresh;
end;

procedure InsertionSort(size:Integer;var a:TBarSeries);
var
   i,j: Integer;
   tmp: Double;

begin

  for i:=0 to size-1 do
  begin
      tmp:=arr[i];
      j:=i;
      while ((j>0)and(arr[j-1]>tmp)) do
      begin
           arr[j]:=arr[j-1];
           j:=j-1;
           updateChart(a);
      end;
      arr[j]:=tmp;
      updateChart(a);
  end;
end;

procedure SelectionSort(size:Integer;var a:TBarSeries);
var
   i,j, tmp: Integer;
   swap: Double;

begin

  for i:=0 to size-2 do
  begin
      tmp:=i;
      for j:=i+1 to size-1 do
      begin
           if arr[j]<arr[tmp] then
              tmp:=j;
      end;
      if tmp<>i then
         begin
              swap:=arr[i];
              arr[i]:=arr[tmp];
              arr[tmp]:=swap;
              updateChart(a);
         end;
  end;
end;

procedure BubbleSort(size:Integer;var a:TBarSeries);
var
   i,j: Integer;
   tmp: Double;

begin

  tmp:=0;

  for i:=0 to size-2 do
  begin
      for j:=i+1 to size-1 do
      begin
          if arr[j]<arr[i] then
             begin
                  tmp:=arr[i];
                  arr[i]:=arr[j];
                  arr[j]:=tmp;
                  updateChart(a);
             end;
      end;
  end;

end;

procedure Merge(l,m,r:Integer;var a:TBarSeries);
var
   i,j,k: Integer;
   b: array of Double;

begin

     setlength(b,l+r);

     i:=l;
     j:=m+1;
     k:=0;

     while ((i<=m) and (j<=r)) do
     begin
          if arr[i]<=arr[j] then
          begin
               b[k]:=arr[i];
               i:=i+1;
          end
          else
          begin
              b[k]:=arr[j];
              j:=j+1;
          end;
          k:=k+1;
     end;

     while i<=m do
     begin
          b[k]:=arr[i];
          i:=i+1;
          k:=k+1;
     end;

     while j<=r do
     begin
          b[k]:=arr[j];
          j:=j+1;
          k:=k+1;
     end;

     for k:=l to r do
     begin
         arr[k]:=b[k-l];
         updateChart(a);
     end;

end;

procedure MergeSort(l,r:Integer;var a:TBarSeries);
var
   m: Integer;

begin

     if l<r then
        begin
             m:=(l+r) div 2;
             MergeSort(l,m,a);
             MergeSort(m+1,r,a);
             Merge(l,m,r,a);
        end;

end;

procedure TVisualizer.GenerateClick(Sender: TObject);
var
  numElements,i: Integer;

begin

   numElements := DimArray.Position;

   setlength(arr,DimArray.Position);

   for i:=0 to numElements-1 do
   begin
       arr[i] := random(1000);
   end;

   updateChart(&ArrDisp);

end;

procedure TVisualizer.StartButtonClick(Sender: TObject);
var
  size:integer;

begin

   size:=length(arr);

   if size>0 then
   begin

      StartButton.Enabled:=false;
      Generate.Enabled:=false;

      case AlgList.ItemIndex of

      0: InsertionSort(size,&ArrDisp);

      1: SelectionSort(size,&ArrDisp);

      2: BubbleSort(size,&ArrDisp);

      3: MergeSort(0,size,&ArrDisp);

      end;

      StartButton.Enabled:=true;
      Generate.Enabled:=true;

   end;

end;

end.

