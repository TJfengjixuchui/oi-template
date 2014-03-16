const
  filename='ditch';
  maxn=200;
  maxm=200;
var
  n,m,s,t,ans:longint;//n,mΪͼ�ĵ�����������s,tΪԴ�㣬��㣬ans��¼�����
  dist,pre:array [1..maxn] of longint;//dist��������ţ�pre��������··��
  flow:array [1..maxn,1..maxn] of longint;//flow���满��ʣ������
 
procedure fopen;
begin
  assign(input,filename+'.in');
  assign(output,filename+'.out');
  reset(input);
  rewrite(output);
end;
 
procedure fclose;
begin
  close(input);
  close(output);
end;
 
procedure init;
var
  i,u,v,w:longint;
begin
  readln(m,n);
    for i:=1 to m do
      begin
        readln(u,v,w);
        inc(flow[u,v],w);
      end;
  s:=1;//Դ��
  t:=n;//���
end;
 
function min(a,b:longint):longint;//ȡ��Сֵ
begin
  if a<b then exit(a)
    else exit(b);
end;
 
procedure augment;
var
  i,delta:longint;
begin
  i:=t;
  delta:=maxlongint;
    while pre[i]<>-1 do
      begin
        delta:=min(delta,flow[pre[i],i]);
        i:=pre[i];
      end;//����������·����С��
  inc(ans,delta);//�����������
  i:=t;
    while pre[i]<>-1 do
      begin
        dec(flow[pre[i],i],delta);//����ǰ��
        inc(flow[i,pre[i]],delta);//���º���
        i:=pre[i];
      end;
end;
 
procedure isap;
var
  i,j,k:longint;
  find:boolean;
  sum:array [0..maxn] of longint;//��¼GAP������
begin
  fillchar(dist,sizeof(dist),0);//��ʼ��������Ϊ0��ʡ��bfs�����ӽ���ʱ�临�Ӷȣ�
  fillchar(sum,sizeof(sum),0);
    for i:=1 to n do inc(sum[dist[i]]);
  fillchar(pre,sizeof(pre),0);
  pre[s]:=-1;
  i:=s;
    while dist[s]<n do
      begin
        find:=false;
          for j:=1 to n do
            if (flow[i,j]>0) and (dist[j]+1=dist[i]) then//�ҵ�һ�����л�
              begin
                find:=true;
                pre[j]:=i;//����·��
                i:=j;//�ؿ��л���ǰ
                break;
              end;
          if find then
            begin
              if i=t then//�ҵ�����·
                begin
                  augment;
                  i:=s;
                end
              else continue;
            end
          else
            begin
              k:=i;
                for j:=1 to n do
                  if (flow[i,j]>0) and (dist[j]<dist[k]) then k:=j;//����С�ľ�����
              dec(sum[dist[i]]);
                if sum[dist[i]]=0 then dist[s]:=n;//GAP�Ż�
              dist[i]:=dist[k]+1;//�޸ľ�����
              inc(sum[dist[i]]);
                if pre[i]<>-1 then i:=pre[i];
            end;
      end;
end;
 
procedure work;
var
  i:longint;
begin
  ans:=0;//��ʼ�������Ϊ0
  isap;//Improved SAP
  writeln(ans);
end;
 
begin
  fopen;
  init;
  work;
  fclose;
end.