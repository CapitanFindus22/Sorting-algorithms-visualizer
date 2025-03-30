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

procedure updateChart(var a:TBarSeries); forward;
procedure InsertionSort(var a:TBarSeries); forward;
procedure SelectionSort(var a:TBarSeries); forward;
procedure BubbleSort(var a:TBarSeries); forward;
procedure QuickSort(l,r:Integer;var a:TBarSeries); forward;
procedure MergeSort(var a:TBarSeries); forward;
procedure GnomeSort(var a:TBarSeries); forward;
procedure CombSort(var a:TBarSeries); forward;
procedure TrippelSort(l,r:Integer;var a:TBarSeries); forward;
procedure PancakeSort(var a:TBarSeries); forward;

{$R *.lfm}

{ TVisualizer }

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

      0: InsertionSort(&ArrDisp);

      1: SelectionSort(&ArrDisp);

      2: BubbleSort(&ArrDisp);

      3: QuickSort(0,size-1,&ArrDisp);

      4: MergeSort(&ArrDisp);

      5: GnomeSort(&ArrDisp);

      6: CombSort(&ArrDisp);

      7: TrippelSort(0,size,&ArrDisp);

      8: PancakeSort(&ArrDisp);

      end;

      StartButton.Enabled:=true;
      Generate.Enabled:=true;

   end;

end;

procedure updateChart(var a:TBarSeries);
begin
  a.Clear;
  a.AddArray(arr);
  Visualizer.Refresh;
end;

procedure InsertionSort(var a:TBarSeries);
var
   i,j: Integer;
   tmp: Double;

begin

  for i:=0 to length(arr)-1 do
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

procedure SelectionSort(var a:TBarSeries);
var
   i,j, tmp: Integer;
   swap: Double;

begin

  for i:=0 to length(arr)-2 do
  begin
      tmp:=i;
      for j:=i+1 to length(arr)-1 do
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

procedure BubbleSort(var a:TBarSeries);
var
   i,j: Integer;
   tmp: Double;

begin

  tmp:=0;

  for i:=0 to length(arr)-2 do
  begin
      for j:=i+1 to length(arr)-1 do
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

function Pivot(l,r:Integer;var a:TBarSeries): Integer;
var
   i,j: Integer;
   tmp,tmp2: Double;

begin

     tmp:=arr[l];
     j:=l;
     for i:=l to r do
     begin
         if arr[i]<tmp then
         begin
              j:=j+1;
              tmp2:=arr[i];
              arr[i]:=arr[j];
              arr[j]:=tmp2;
              updateChart(a);
         end;
     end;
     arr[l]:=arr[j];
     updateChart(a);
     arr[j]:=tmp;
     updateChart(a);
     Pivot:=j;
end;

procedure QuickSort(l,r:Integer;var a:TBarSeries);
var
   m: Integer;

begin

     if l<r then
     begin
     m:=Pivot(l,r,a);
     QuickSort(l,m-1,a);
     QuickSort(m+1,r,a);
     end;
end;

procedure merge(p,q,r:integer;var a:TBarSeries);
var
   i,j,k,n1,n2:integer;
   B: array of Double;
begin

  setlength(B,length(arr));

  n1 := q - p + 1;
  n2 := r - q;
  for k := p to r do
      B[k - p + 1] := arr[k];
  i := 1;
  j := n1 + 1;
  k := p;
  while(i <= n1)and(j <= n1 + n2)do
  begin
    if B[i] <= B[j] then
    begin
      arr[k] := B[i];
      updateChart(a);
      i := i + 1;
    end
    else
    begin
      arr[k] := B[j];
      updateChart(a);
      j := j + 1;
    end;
    k := k + 1;
  end;
  while i <= n1 do
  begin
    arr[k] := B[i];
    updateChart(a);
    i := i + 1;
    k := k + 1;
  end;
  while j <= n1 + n2 do
  begin
    arr[k] := B[j];
    j := j + 1;
    k := k + 1;
  end;
end;

procedure MergeSort(var a:TBarSeries);
var p,q,r,k,n:integer;
begin
  n:=length(arr);
  k := 1;
  while k <= n do
  begin
    p := 0;
    while p + k <= n do
    begin
      q := p + k - 1;
      if p + 2 * k - 1 < n then
        r := p + 2 * k - 1
      else
        r := n;
      merge(p,q,r,a);
      p := p + 2 * k;
    end;
    k := k * 2;
  end;
end;

procedure GnomeSort(var a:TBarSeries);
var
   i: Integer;
   tmp: Double;

begin

     i:=0;
     while i<length(arr) do
     begin
         if ((i=0) or (arr[i]>=arr[i-1])) then
         begin
              i:=i+1;
         end
         else
         begin
              tmp:=arr[i];
              arr[i]:=arr[i-1];
              arr[i-1]:=tmp;
              updateChart(a);
              i:=i-1;
         end;
     end;
end;

procedure CombSort(var a:TBarSeries);

const shrink=1.3;

var
   i,gap: Integer;
   sorted: Boolean;
   tmp: Double;

begin

     gap:=length(arr);
     sorted:=false;

     while (not sorted) do
     begin

         gap:= Trunc(gap/shrink);

         if gap<=1 then
         begin
            gap:=1;
            sorted:=true;
         end
         else if ((gap=9)or(gap=10)) then
         begin
              gap:=11;
         end;

         i:=0;

         while (i+gap)<length(arr) do
         begin

             if arr[i]>arr[i+gap] then
             begin
                  tmp:=arr[i];
                  arr[i]:=arr[i+gap];
                  arr[i+gap]:=tmp;
                  sorted:=false;
                  updateChart(a);
             end;
             i:=i+1;
         end;
     end;

end;

procedure TrippelSort(l,r:Integer;var a:TBarSeries);
var
   size,k: Integer;
   tmp: Double;

begin
     size:=r-l+1;

     if size>=3 then
     begin
        k:=size div 3;
        TrippelSort(l,r-k,a);
        TrippelSort(l+k,r,a);
        TrippelSort(l,r-k,a);
     end
     else if arr[l]>arr[r] then
     begin
          tmp:=arr[l];
          arr[l]:=arr[r];
          arr[r]:=tmp;
          updateChart(a);
     end;
end;

procedure flip(k:Integer;var a:TBarSeries);
var
   l:Integer;
   tmp:Double;

begin
     l:=0;

     while l<k do
     begin
         tmp:=arr[l];
         arr[l]:=arr[k];
         arr[k]:=tmp;
         updateChart(a);
         k:=k-1;
         l:=l+1;
     end;
end;

function maxIndex(k:Integer): Integer;
var
   i,j:Integer;

begin
     j:=0;

     for i:=0 to k-1 do
     begin
          if arr[i]>arr[j] then
             j:=i;
     end;
     result:=j;

end;

procedure PancakeSort(var a:TBarSeries);
var
   n,maxind: Integer;

begin

     n:=length(arr);

     while n>1 do
     begin
          maxind:=maxIndex(n);

          if maxind<>n-1 then
          begin
               if maxind<>0 then
                  flip(maxind,a);
               flip(n-1,a);
          end;
          n:=n-1;

     end;

end;

end.

