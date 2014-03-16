var
  flag:boolean;
  jl,min,flow,aug,j,m,n,tmp,a,b,c,i:longint;
  his,pre,dis,vh,di:array[0..1024] of longint;
  map:array[1..1024,1..1024] of longint;
begin
  assign(input,'ditch.in');reset(input);
  assign(output,'ditch.out');rewrite(output);
  readln(m,n);
  for i:=1 to m do
   begin
     readln(a,b,c);
     inc(map[a,b],c);
   end;

vh[0]:=n;

for i:=1 to n do di[i]:=1;{��ǰ����ʼΪ��һ����}

i:=1;{��S��ʼ��}
aug:=maxlongint;
while dis[1]<n do
 begin
  his[i]:=aug;{��ǣ��Ա��Ժ󷵻����ֵ}
  flag:=false;{������Ƿ����ҵ������ı�־}
  for j:=di[i] to n do{�ӵ�ǰ����ʼ��}
     begin
       if (map[i,j]>0)and(dis[j]+1=dis[i]) then{�ҵ�����}
       begin
         flag:=true;
         di[i]:=j;{��ǵ�ǰ��}
         if map[i,j]<aug then aug:=map[i,j];
         pre[j]:=i;{��¼ǰ��}
         i:=j;
         if i=n then{�ҵ�����·}
           begin
            inc(flow,aug);
             while i<>1 do
               begin
                tmp:=i;
                i:=pre[i];
                dec(map[i,tmp],aug);
                inc(map[tmp,i],aug);
              end;
            aug:=maxlongint;
          end;
        break;{�ҵ��������˳�����}
      end;
    end;
 if flag then continue;{�ҵ�����}
 min:=n-1;{û�������ˣ���Ҫ�ر��}
 for j:=1 to n do
   begin
     if (map[i,j]>0)and(dis[j]<min) then 
          begin 
             jl:=j;
             min:=dis[j];
          end;
   end;
 di[i]:=jl;
 dec(vh[dis[i]]);{GAP�Ż�}
 if vh[dis[i]]=0 then break;
 dis[i]:=min+1;
 inc(vh[dis[i]]);
 if i<>1 then 
    begin 
        i:=pre[i];{������һ��}
       aug:=his[i];{֪��֮ǰ��¼���ֵ���ô��˰�}
    end;
 end;
 write(flow);
 close(input);
 close(output);
end.

�Ż���

1.�ڽӱ��Ż���
��������Ļ�������N^2�治�£���ʱ���Ҫ��ߣ�
��ÿ���ߵĳ����㣬��ֹ��ͼ�ֵ��Ȼ������һ�£�
�ټ�¼ÿ���������λ�á��Ժ�Ҫ���ôӳ���������ı�ʱ��
ֻ��Ҫ�Ӽ�¼��λ�ÿ�ʼ�Ҽ��ɣ���ʵ������������
�ŵ���ʱ��ӿ�ռ��ʡ��ȱ���Ǳ�̸��ӶȽ������������Ŀ���������£�����ʹ���ڽӾ���

2.GAP�Ż���
���һ���ر��ʱ�����־���ϲ㣬�����֤��ST�޿���������ʱ�����ֱ���˳��㷨��

3.��ǰ���Ż���
Ϊ��ʹÿ��������·��ʱ���ɾ�̯O(V)��
����һ����Ҫ���Ż��Ƕ���ÿ���㱣�桰��ǰ��������ʼʱ��ǰ�����ڽӱ�ĵ�һ������
���ڽӱ��в���ʱ�ӵ�ǰ����ʼ���ң��ҵ���һ���������Ͱ���������Ϊ��ǰ����
�ı������ʱ���ѵ�ǰ��������Ϊ�ڽӱ�ĵ�һ������

�����������㷨
const
  fin='maxflow.in';
  fout='maxflow.out';
  maxn=100;
type
  tline=array[0..maxn]of integer;
  tmap=array[1..maxn]of tline;
var
  n:integer;
  limit,flow:tmap;

procedure getinfo;
var
  i,j,c:integer;
begin
  assign(input,fin);reset(input);
  readln(n);
  while not seekeof do
    begin
      readln(i,j,c);
      limit[i,j]:=c;
    end;
  close(input);
end;

procedure maxflow;
var
  i,j,delta,x:integer;
  last:tline;
  check:array[0..maxn]of boolean;
begin
  repeat
    fillchar(last,sizeof(last),0);
    fillchar(check,sizeof(check),0);
    last[1]:=maxint;
    repeat
      i:=0;
      repeat
        inc(i);
      until (i>n) or (last[i]<>0) and not check[i];
      if i>n then break;
      for j:=1 to n do
        if last[j]=0 then
          if flow[i,j]<limit[i,j] then
            last[j]:=i
          else
            if flow[j,i]>0 then last[j]:=-i;
      check[i]:=true;
    until last[n]<>0;
    if last[n]=0 then break;
    delta:=maxint;
    repeat
      j:=i;i:=abs(last[j]);
      if last[j]>0 then x:=limit[i,j]-flow[i,j]
                   else x:=flow[j,i];
      if x<delta then delta:=x;
    until i=1;
    i:=n;
    repeat
      j:=i;i:=abs(last[j]);
      if last[j]>0 then inc(flow[i,j],delta)
                   else dec(flow[j,i],delta);
    until i=1;
  until false;
end;

procedure print;
var
  i,j,sum:integer;
begin
  sum:=0;
  assign(output,fout);rewrite(output);
  for i:=1 to n do
    for j:=1 to n do
      if flow[i,j]>0 then
        begin
          if i=1 then inc(sum,flow[i,j]);
          writeln(i,'->',j,' ',flow[i,j]);
        end;
  writeln('maxflow=',sum);
  close(output);
end;

begin
  getinfo;
  maxflow;
  print;
end.


