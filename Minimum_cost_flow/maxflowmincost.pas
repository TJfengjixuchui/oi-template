program Maxflow_With_MinCost;
const
  name1='flow.in';
  name2='flow.out';
  maxN=100;{��ඥ����}
type
  Tbest=record  {����Ľṹ}
      value,fa:integer;
    end;{��Դ�����̾��룬����}
  Nettype=record
    {�����ڽӾ�������}
    c,w,f:integer;
    {������������λͨ�������ã�����}
    end;
var
  Net:array[1..maxN,1..maxN] Of Nettype;
     {����N���ڽӾ���}
  n,s,t:integer;{��������Դ�㡢���ı��}
  Minw:integer;{��С�ܷ���}
  best:array[1..maxN] of Tbest;{�����·ʱ�õ�����}

procedure Init;{���ݶ���}
var inf:text;
    a,b,c,d:integer;
begin
  fillchar(Net,sizeof(Net),0);
  Minw:=0;
  assign(inf,name1);
  reset(inf);
  readln(inf,n);
  s:=1;t:=n;{Դ��Ϊ1�����n}
  repeat
    readln(inf,a,b,c,d);
    if a+b+c+d>0 then
    begin
    Net[a,b].c:=c;{����(a,b)������c}
    Net[b,a].c:=0;{���෴��(b,a)������0}
    Net[a,b].w:=d;{����(a,b)������d}
    Net[b,a].w:=-d;{���෴��(b��a)������-d}
    end;
  until a+b+c+d=0;
  close(inf);
end;

function Find_Path:boolean;
{����С��������·����,��best[t].value<>MaxInt,
���ҵ�����·����������true�����򷵻�false}
var Quit:Boolean;
    i,j:Integer;
begin
  for i:=1 to n do best[i].value:=Maxint;best[s].value:=0;
  {Ѱ����С��������·��ǰ����best���鸳��ֵ}
  repeat
    Quit:=True;
    for i:=1 to n do
      if best[i].Value < Maxint then
        for j:=1 to n do
          if (Net[i,j].f < Net[i,j].c) and
          (best[i].value + Net[i,j].w <
          best[j].value) then
          begin
            best[j].value:=best[i].value + Net[i,j].w;
            best[j].fa := i;
            Quit:= False;
          end;
  until Quit;
  if best[t].value<Maxint then find_path:=true else find_path:=false;
end;

procedure Add_Path;
var i,j: integer;
begin
  i:= t;
  while i <> s do
    begin
      j := best[i].fa;
      inc(Net[j,i].f); {����·�ǻ��������޸ģ�����1}
      Net[i,j].f:=-Net[j,i].f;{����Ӧ�෴����������ֵ-f}
      i:=j;
    end;
    inc(Minw,best[t].value); {�޸���С�ܷ��õ�ֵ}
end;

procedure Out;{�����С����������ķ��ü�����}
var ouf: text;
    i,j: integer;
begin
  assign(ouf,name2);
  rewrite(ouf);
  writeln(ouf,'Min w = ',Minw);
  for i := 1 to n do
    for j:= 1 to n do
      if Net[i,j].f > 0 then
        writeln(ouf,i, ' -> ',j,': ',
         Net[i,j].w,'*',Net[i,j].f);
   close(ouf);
end;

Begin {������}
   Init;
   while Find_Path do Add_Path;
   {���ҵ���С��������·���޸���}
   Out;
end. 

