
%Sentetik veri seti üretelim

veriSeti_in = randi([-5 10],125,2);
d = length(veriSeti_in);

veriSeti_out=[];

for ii = 1:(d)
    xi = veriSeti_in(ii);
    xnext = veriSeti_in(ii+1);
    new = 100*(xnext-xi^2)^2 + (xi-1)^2;
    veriSeti_out = [veriSeti_out, new];
end

New_veriSeti_out = transpose(veriSeti_out);

VS=[veriSeti_in New_veriSeti_out];

egt=VS(1:75,:);
test=VS(76:125,:);

%Veri setinin rasgele olarak %75eðitim kümesine, %25 test kümesine atanýr
%Hiper paramtre deðerleri atanýyor
pop_uz=5;
pc=7,7055;
pm=5;
% Her bir Kromozom reel sayýlar kullanýlarak kodlanacak
%Her bir degiskenin degisim araligi [-5 10] olarak kabul ediyoruz.
%kromozomdaki gen sayisini, 2 girisli, sirayla 2 ve 4 dilsel degere sahip
%oldugu kabul edildi.
%Her bir dilsel deðerin GaussMf ile temsil edildigi kabul edildi. bu göre
%kromozom boyutu 36 olarak hesaplandi. 5 bireyli bir populasyon üretildi
pop=randi([-5 10],pop_uz,36); %baslangic populasyonu olusturuldu.
%tempfis=readfis(mainFis);

fitness_mseList = [];

tempfis = readfis("BM_19_069MyFis.fis");

%egitim 1
for i=1:5
    % Kuralýn öncül kýsýmlarý(premise part)
    tempfis.input(1,1).mf(1,1).params=pop(i,1:2); %X deðiþkenine ait A1 dilsel deðeri
    tempfis.input(1,1).mf(1,2).params=pop(i,3:4); %X deðiþkenine ait A2 dilsel deðeri

     
    tempfis.input(1,2).mf(1,1).params=pop(i,5:6); %Y deðiþkenine ait B1 dilsel deðeri
    tempfis.input(1,2).mf(1,2).params=pop(i,7:8); %y deðiþkenine ait B2 dilsel deðeri
    tempfis.input(1,2).mf(1,3).params=pop(i,9:10); %Y deðiþkenine ait B1 dilsel deðeri
    tempfis.input(1,2).mf(1,4).params=pop(i,11:12); %y deðiþkenine ait B2 dilsel deðeri

    %Kuralýn soncul kýsmý:(lineer olarak kodlanan kýsmý pi,qi ve ri
    tempfis.output.mf(1,1).params=pop(i,13:15); % p1,q1,r1
    tempfis.output.mf(1,2).params=pop(i,16:18); %p2,q2,r2
    tempfis.output.mf(1,3).params=pop(i,19:21); %p3, q3, r3
    tempfis.output.mf(1,4).params=pop(i,22:24); % p4, q4, r4
    tempfis.output.mf(1,5).params=pop(i,25:27); % p1,q1,r1
    tempfis.output.mf(1,6).params=pop(i,28:30); %p2,q2,r2
    tempfis.output.mf(1,7).params=pop(i,31:33); %p3, q3, r3
    tempfis.output.mf(1,8).params=pop(i,34:36); % p4, q4, r4
    
    hesaplan_cikis= evalfis(egt(:,1:2),tempfis);
    %MSE hesaplayacagým
    fitness_mse(i,1)=sum((egt(:,3)-hesaplan_cikis).^2)/length(egt(:,1));
    fitness_mseList = [fitness_mseList, sum((egt(:,3)-hesaplan_cikis).^2)/length(egt(:,1))];
end;


%egitim 2
%yeni pop
pop = xlsread("BM_19_069NewPop.xlsx");
for i=1:5
    % Kuralýn öncül kýsýmlarý(premise part)
    tempfis.input(1,1).mf(1,1).params=pop(i,1:2); %X deðiþkenine ait A1 dilsel deðeri
    tempfis.input(1,1).mf(1,2).params=pop(i,3:4); %X deðiþkenine ait A2 dilsel deðeri

     
    tempfis.input(1,2).mf(1,1).params=pop(i,5:6); %Y deðiþkenine ait B1 dilsel deðeri
    tempfis.input(1,2).mf(1,2).params=pop(i,7:8); %y deðiþkenine ait B2 dilsel deðeri
    tempfis.input(1,2).mf(1,3).params=pop(i,9:10); %Y deðiþkenine ait B1 dilsel deðeri
    tempfis.input(1,2).mf(1,4).params=pop(i,11:12); %y deðiþkenine ait B2 dilsel deðeri

    %Kuralýn soncul kýsmý:(lineer olarak kodlanan kýsmý pi,qi ve ri
    tempfis.output.mf(1,1).params=pop(i,13:15); % p1,q1,r1
    tempfis.output.mf(1,2).params=pop(i,16:18); %p2,q2,r2
    tempfis.output.mf(1,3).params=pop(i,19:21); %p3, q3, r3
    tempfis.output.mf(1,4).params=pop(i,22:24); % p4, q4, r4
    tempfis.output.mf(1,5).params=pop(i,25:27); % p1,q1,r1
    tempfis.output.mf(1,6).params=pop(i,28:30); %p2,q2,r2
    tempfis.output.mf(1,7).params=pop(i,31:33); %p3, q3, r3
    tempfis.output.mf(1,8).params=pop(i,34:36); % p4, q4, r4
    
    hesaplan_cikis= evalfis(egt(:,1:2),tempfis);
    %MSE hesaplayacagým
    fitness_mse(i,1)=sum((egt(:,3)-hesaplan_cikis).^2)/length(egt(:,1));
    fitness_mseList = [fitness_mseList, sum((egt(:,3)-hesaplan_cikis).^2)/length(egt(:,1))];
end;

% Test MyFis
for i=1:5
    % Kuralýn öncül kýsýmlarý(premise part)
    tempfis.input(1,1).mf(1,1).params=pop(i,1:2); %X deðiþkenine ait A1 dilsel deðeri
    tempfis.input(1,1).mf(1,2).params=pop(i,3:4); %X deðiþkenine ait A2 dilsel deðeri

     
    tempfis.input(1,2).mf(1,1).params=pop(i,5:6); %Y deðiþkenine ait B1 dilsel deðeri
    tempfis.input(1,2).mf(1,2).params=pop(i,7:8); %y deðiþkenine ait B2 dilsel deðeri
    tempfis.input(1,2).mf(1,3).params=pop(i,9:10); %Y deðiþkenine ait B1 dilsel deðeri
    tempfis.input(1,2).mf(1,4).params=pop(i,11:12); %y deðiþkenine ait B2 dilsel deðeri

    %Kuralýn soncul kýsmý:(lineer olarak kodlanan kýsmý pi,qi ve ri
    tempfis.output.mf(1,1).params=pop(i,13:15); % p1,q1,r1
    tempfis.output.mf(1,2).params=pop(i,16:18); %p2,q2,r2
    tempfis.output.mf(1,3).params=pop(i,19:21); %p3, q3, r3
    tempfis.output.mf(1,4).params=pop(i,22:24); % p4, q4, r4
    tempfis.output.mf(1,5).params=pop(i,25:27); % p1,q1,r1
    tempfis.output.mf(1,6).params=pop(i,28:30); %p2,q2,r2
    tempfis.output.mf(1,7).params=pop(i,31:33); %p3, q3, r3
    tempfis.output.mf(1,8).params=pop(i,34:36); % p4, q4, r4
    
    hesaplan_cikis= evalfis(test(:,1:2),tempfis);
    %MSE hesaplayacagým
    fitness_mse(i,1)=sum((test(:,3)-hesaplan_cikis).^2)/length(test(:,1));
    fitness_mseList = [fitness_mseList, sum((test(:,3)-hesaplan_cikis).^2)/length(test(:,1))];
end;

% Test AnfisToolbox

% egitilmis fis
tempfis = readfis("BM_19_069Anfis.fis");

for i=1:5
    hesaplan_cikis= evalfis(test(:,1:2),tempfis);
    %MSE hesaplayacagým
    fitness_mse(i,1)=sum((test(:,3)-hesaplan_cikis).^2)/length(test(:,1));
    fitness_mseList = [fitness_mseList, sum((test(:,3)-hesaplan_cikis).^2)/length(test(:,1))];
end;