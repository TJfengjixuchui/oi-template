program axis;
var
   t:array[0..2000000,1..3]of longint;
   m,n,x,y,i:longint;
procedure inset(p,x,y:longint);
begin
     if i<p then
     i:=p;
     t[p,1]:=x;
     t[p,2]:=y;
     if x<y then
     begin
          inset(p*2,x,(x+y)div 2);
          inset(p*2+1,(x+y)div 2+1,y);
     end;
end;
procedure delete(p,x,y:longint);
var
   mid,xx,yy:longint;
begin
     if t[p,3]<>0 then
     exit;
     xx:=t[p,1];
     yy:=t[p,2];
     if (x=t[p,1])and(y=t[p,2])then
     t[p,3]:=1
     else
     begin
          mid:=(t[p,1]+t[p,2])div 2;
          if y<=mid then
          delete(p*2,x,y)
          else
          if x>mid then
          delete(p*2+1,x,y)
          else
          begin
               delete(p*2,x,mid);
               delete(p*2+1,mid+1 ,y);
          end;
     end;
end;
function count(p:longint):longint;
begin
     if t[p,3]=1 then
     exit(t[p,2]-t[p,1]+1)
     else
     if t[p,2]-t[p,1]=0 then
     exit(0)
     else
     exit(count(p*2)+count(p*2+1));
end;
begin
     assign(input,'axis.in');
     assign(output,'axis.out');
     reset(input);
     rewrite(output);
     readln(n,m);
     inset(1,1,n);
     for i:=1 to m do
     begin
          readln(x,y);
          delete(1,x,y);
          writeln(n-count(1));
     end;

     close(input);
     close(output);
end.

