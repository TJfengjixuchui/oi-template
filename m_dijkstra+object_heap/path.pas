program path;
const
     maxn=1010000;
     maxm=10010000;

type
    node=record
               d,v:longint;
    end;
var
 head,dis,pos : array[0..maxn]of longint;
           u  : array[0..maxn]of boolean;
     v,d,next : array[0..maxm]of longint;
      num,n,m : longint;

a:array[0..maxm]of node;
ge:longint;

procedure up(i:longint);
var
  t:node;
begin
    t:=a[i];
    while(i>1)do
         if t.d<a[i shr 1].d then
         begin pos[a[i shr 1].v]:=i;a[i]:=a[i shr 1];i:=i shr 1; end
         else break;
    a[i]:=t;
    pos[a[i].v]:=i;
end;

procedure insert(x,v:longint);
begin
    inc(ge);
    a[ge].d:=x; a[ge].v:=v;pos[v]:=ge;
    up(ge);
end;

procedure down(i:longint);
var
  t:node;j:longint;
begin
    t:=a[i]; j:=i shl 1;
    while j<=ge do
    begin

         if(j+1<=ge)and(a[j].d>a[j+1].d)then inc(j);
         if t.d>a[j].d then
         begin
         pos[a[j].v]:=i;
         a[i]:=a[j];i:=j;j:=j shl 1
         end
         else break;
    end;
    a[i]:=t;pos[a[i].v]:=i;
end;

procedure pop;
begin
    a[1]:=a[ge]; dec(ge);   down(1);
end;

  procedure add(x, y, z: longint);
  begin
    Inc(num);d[num]:=z;  v[num]:= y;  Next[num]:= head[x]; head[x]:=num;
  end;

  procedure dijkstra(x:longint);
  var
     now:longint;i:longint;
  begin
       for i:=1 to n do
       dis[i]:=high(longint);

       i:=head[x];
       while i<>0 do
       begin
            insert(d[i],v[i]);
            i:=next[i];
       end;

       while ge>0 do
       begin
            now:=a[1].v;
	    while u[now] do
	    begin
            	pop;
		now:=a[1].v;
	    end;
            u[now]:=true;
  	    if dis[now]>a[1].d then
            dis[now]:=a[1].d;
            pop;
            i:=head[now];
            while i<>0 do
            begin
                 if((pos[v[i]]=0)or(a[pos[v[i]]].d>dis[now]+d[i]))and(not u[v[i]])then
                 begin
                     if pos[v[i]]<>0 then
                     begin
                     a[pos[v[i]]].d:=dis[now]+d[i];
                     up(pos[v[i]]);
                     end
                     else
                     insert(dis[now]+d[i],v[i]);
                 end;
                 i:=next[i];
            end;
       end;

  end;

procedure init;
var
   x,y,z:longint;i:longint;
begin
     readln(n ,m);
     for i:=1 to m do
     begin
          readln(x,y,z);
          add(x,y,z);
          add(y,x,z);
     end;
     randomize;
     dijkstra(1);
     for i:=2 to n do
     writeln(dis[i]);
end;

begin
     assign(input,'path.in');assign(output,'path.out');
     reset(input);rewrite(output);

     init;

     close(input);close(output);
end.
