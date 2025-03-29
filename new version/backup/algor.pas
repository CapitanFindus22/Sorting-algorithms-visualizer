unit Algor;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

implementation
uses main;

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

end.

