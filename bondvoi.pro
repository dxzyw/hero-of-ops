; calculate bondorder with reference to JCP (revised VOI method)
; the result array is explained as follows:
;  
;method=1; the voi method,
;method=2, the bond split method
function cal_area,pos,conn
n=n_elements(conn[0,*])
area=0
for i=0.,n-1 do begin
 pos0=pos[*,conn[0,i]]
 pos1=pos[*,conn[1,i]]
 pos2=pos[*,conn[2,i]]
 v1=pos1-pos0
 v2=pos2-pos0
 area+=norm(crossp(v1,v2))
endfor
return,0.5*area
end

;=================================================================================================
function firstfloor_search,gr
totalnumber=n_elements(gr(0,*))
number_of_ymax=where(gr(1,*) eq max(gr(1,*)))
number_of_ymax=number_of_ymax(0)
minimum=gr(1,number_of_ymax)
order=number_of_ymax
for i=number_of_ymax,totalnumber-2 do begin
 if gr(1,i) lt minimum then begin
  minimum=gr(1,i)
  order=i
 endif
endfor
return,gr(0,order)
end




function voronoicell_con,trb,v1=v1
start=systime(/second)
c1=trb(0:2,*)
na=n_elements(c1(0,*))
vl=fltarr(6,na)
vl(0:2,*)=c1
qhull,c1,tr1,connectivity=con1,vvertices=v1,vdiagram=vdi,/delaunay
result=dblarr(na,201,2)
i=0.
n=n_elements(vdi)
while i lt n do begin
 nb=vdi[i]
 particle1id=vdi[++i]
 particle2id=vdi[++i]
 w22=con1[con1[particle1id]:con1[particle1id+1]-1]
 neighornot=where(w22 eq particle2id)
 if neighornot[0] eq -1 then begin
  i+=nb+1
 endif
 result[particle1id,0,0]++
 result[particle2id,0,0]++
 i++
 commom=vdi[i:i+nb-3]
 if min(commom) lt 0 then begin
  i+=nb-2
  continue
 end
 ncommom=n_elements(commom)
 refer=crossp(v1[*,commom[1]],v1[*,commom[2]])+v1[*,commom[1]]
 qhull,[[v1[0:2,commom]],[refer]],trv1
 w=where((trv1[2,*] ne ncommom) and trv1[0,*] ne ncommom and trv1[1,*] ne ncommom)
 trv11=trv1[*,w]
 area=cal_area(v1[0:2,commom],trv11)
 result[particle1id,result[particle1id,0,0],0]=particle2id 
 result[particle1id,result[particle1id,0,0],1]=area
 result[particle2id,result[particle2id,0,0],0]=particle1id
 result[particle2id,result[particle2id,0,0],1]=area
 result[particle1id,0,1]+=area
 result[particle2id,0,1]+=area
 i+=nb-2
endwhile
endtime=systime(/second)
print,'running time',endtime-start
return,result
end

function cal_q6,c1,area,q6m=q6m
 sph1=cv_coord(from_rect=c1,/to_sphere)
 sph1(1,*)=!pi/2-sph1(1,*)
 totalarea=area[0]
 neinum=n_elements(area)-1
 q66=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),6,-1)/totalarea)
 q65=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),6,-2)/totalarea)
 q64=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),6,-3)/totalarea)
 q63=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),6,-4)/totalarea)
 q62=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),6,-5)/totalarea)
 q61=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),6,-6)/totalarea)
 q67=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),6,0)/totalarea)
 q68=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),6,1)/totalarea)
 q69=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),6,2)/totalarea)
 q610=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),6,3)/totalarea)
 q611=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),6,4)/totalarea)
 q612=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),6,5)/totalarea)
 q613=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),6,6)/totalarea)
 qq66=(abs(q66))^2
 qq65=(abs(q65))^2
 qq64=(abs(q64))^2
 qq63=(abs(q63))^2
 qq62=(abs(q62))^2
 qq61=(abs(q61))^2
 qq67=(abs(q67))^2
 qq68=(abs(q68))^2
 qq69=(abs(q69))^2                                                                                                                   
 qq610=(abs(q610))^2
 qq611=(abs(q611))^2
 qq612=(abs(q612))^2
 qq613=(abs(q613))^2
 q6m=[q61,q62,q63,q64,q65,q66,q67,q68,q69,q610,q611,q612,q613]
 qq6m=[qq61,qq62,qq63,qq64,qq65,qq66,qq67,qq68,qq69,qq610,qq611,qq612,qq613]
 q6=sqrt((4.*!pi)*total(qq6m)/(2*6+1.))
 return,q6
end


function cal_q4,c1,area,q4m=q4m
 sph1=cv_coord(from_rect=c1,/to_sphere)
 sph1(1,*)=!pi/2-sph1(1,*)
 totalarea=area[0]
 neinum=n_elements(area)-1
 q41=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),4,-4)/totalarea)
 q42=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),4,-3)/totalarea)
 q43=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),4,-2)/totalarea)
 q44=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),4,-1)/totalarea)
 q45=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),4,0)/totalarea)
 q46=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),4,1)/totalarea)
 q47=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),4,2)/totalarea)
 q48=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),4,3)/totalarea)
 q49=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),4,4)/totalarea)
 qq46=(abs(q46))^2                                                                        
 qq45=(abs(q45))^2
 qq44=(abs(q44))^2
 qq43=(abs(q43))^2
 qq42=(abs(q42))^2
 qq41=(abs(q41))^2
 qq47=(abs(q47))^2
 qq48=(abs(q48))^2
 qq49=(abs(q49))^2
 q4m=[q41,q42,q43,q44,q45,q46,q47,q48,q49]
 qq4m=[qq41,qq42,qq43,qq44,qq45,qq46,qq47,qq48,qq49]
 q4=sqrt((4.*!pi)*total(qq4m)/(2*4+1.))
 return,q4 
end


function cal_q8,c1,area,q8m=q8m
 sph1=cv_coord(from_rect=c1,/to_sphere)
 sph1(1,*)=!pi/2-sph1(1,*)
 totalarea=area[0]
 neinum=n_elements(area)-1
 q86=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),8,-3)/totalarea)
 q85=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),8,-4)/totalarea)
 q84=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),8,-5)/totalarea)
 q83=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),8,-6)/totalarea)
 q82=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),8,-7)/totalarea)
 q81=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),8,-8)/totalarea)
 q87=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),8,-2)/totalarea)
 q88=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),8,-1)/totalarea)
 q89=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),8,0)/totalarea)
 q810=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),8,1)/totalarea)
 q811=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),8,2)/totalarea)
 q812=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),8,3)/totalarea)
 q813=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),8,4)/totalarea)
 q814=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),8,5)/totalarea)
 q815=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),8,6)/totalarea)
 q816=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),8,7)/totalarea)
 q817=total(area[1:neinum]*spher_harm(sph1(1,*),sph1(0,*),8,8)/totalarea)
 qq86=(abs(q86))^2
 qq85=(abs(q85))^2
 qq84=(abs(q84))^2
 qq83=(abs(q83))^2
 qq82=(abs(q82))^2
 qq81=(abs(q81))^2
 qq87=(abs(q87))^2
 qq88=(abs(q88))^2
 qq89=(abs(q89))^2
 qq810=(abs(q810))^2
 qq811=(abs(q811))^2
 qq812=(abs(q812))^2
 qq813=(abs(q813))^2
 qq814=(abs(q814))^2
 qq815=(abs(q815))^2
 qq816=(abs(q816))^2
 qq817=(abs(q817))^2
 q8m=[q81,q82,q83,q84,q85,q86,q87,q88,q89,q810,q811,q812,q813,q814,q815,q816,q817]
 qq8m=[qq81,qq82,qq83,qq84,qq85,qq86,qq87,qq88,qq89,qq810,qq811,qq812,qq813,qq814,qq815,qq816,qq817]
 q8=sqrt((4*!pi)*total(qq8m)/(2*8+1))
 return,q8 
end



function q4q6_origin,trb,deltar=deltar,qq4m=qq4m,qq6m=qq6m,qq8m=qq8m,con=con,bondnum=bondnum,nosplit=nosplit,bondmax=bondmax
start=systime(/second)
if (not keyword_set(bondmax)) then bondmax=14
particlenum=n_elements(trb[0,*])
pos=trb[0:2,*]
bondnum=fltarr(particlenum)
qq6m=complexarr(13,particlenum)
qq4m=complexarr(9,particlenum)
qq8m=complexarr(17,particlenum)
con=fltarr(particlenum,bondmax+1,2)
con1=fltarr(particlenum,bondmax+1,2)
q4=fltarr(particlenum)
q6=fltarr(particlenum)
q8=fltarr(particlenum)
for j=0.,particlenum-1 do begin
 dx=pos(0,*)-pos(0,j)
 dy=pos(1,*)-pos(1,j)
 dz=pos(2,*)-pos(2,j)
 wwww=where(abs(dx) le 1.5*deltar and abs(dy) le 1.5*deltar and abs(dz) le 1.5*deltar,nwwww)
 if nwwww lt 4 then continue
 dx=dx[0,wwww]
 dy=dy[0,wwww] 
 dz=dz[0,wwww]
 a1=(dx)^2+(dy)^2+(dz)^2
 aa1=sort(a1)
 
 ww=aa1[1:min([bondmax,nwwww-1])]
 aaa1=a1[ww]
 ddx=dx(0,ww)
 ddy=dy(0,ww)
 ddz=dz(0,ww)
 w=where(aaa1 gt 0. and aaa1 le deltar^2,nc1)
 if nc1 eq 0 then continue
 con[j,0,0]=nc1
 con1[j,0,0]=nc1
 bondnum[j]=nc1
 con[j,1:con[j,0,0],0]=wwww[ww[w]]
 
 if (not keyword_set(nosplit)) then begin
  if nc1 eq 13.0 then begin
    if sqrt(aaa1[12])+sqrt(aaa1[13]) le 2.0*deltar then begin
      w=[0,1,2,3,4,5,6,7,8,9,10,11,12,13]
      con1[j,0,0]=14
      bondnum[j]=13.5 
    endif
    if sqrt(aaa1[12])+sqrt(aaa1[13]) gt 2.0*deltar then begin
       w=[0,1,2,3,4,5,6,7,8,9,10,11]
       con1[j,0,0]=12
       bondnum[j]=12.5
    endif
  endif
 endif 
    con1[j,1:con1[j,0,0],0]=wwww[ww[w]]
    b1=n_elements(w)

    
 if w[0] ne -1 then begin
  c1=findgen(3,b1)
  c1(0,*)=ddx(0,w)
  c1(1,*)=ddy(0,w)
  c1(2,*)=ddz(0,w)
  sph1=cv_coord(from_rect=c1,/to_sphere)
  sph1(1,*)=!pi/2-sph1(1,*)
  q66=mean(spher_harm(sph1(1,*),sph1(0,*),6,-1))
  q65=mean(spher_harm(sph1(1,*),sph1(0,*),6,-2))
  q64=mean(spher_harm(sph1(1,*),sph1(0,*),6,-3))
  q63=mean(spher_harm(sph1(1,*),sph1(0,*),6,-4))
  q62=mean(spher_harm(sph1(1,*),sph1(0,*),6,-5))
  q61=mean(spher_harm(sph1(1,*),sph1(0,*),6,-6))
  q67=mean(spher_harm(sph1(1,*),sph1(0,*),6,0))
  q68=mean(spher_harm(sph1(1,*),sph1(0,*),6,1))
  q69=mean(spher_harm(sph1(1,*),sph1(0,*),6,2))
  q610=mean(spher_harm(sph1(1,*),sph1(0,*),6,3))
  q611=mean(spher_harm(sph1(1,*),sph1(0,*),6,4))
  q612=mean(spher_harm(sph1(1,*),sph1(0,*),6,5))
  q613=mean(spher_harm(sph1(1,*),sph1(0,*),6,6))
  q41=mean(spher_harm(sph1(1,*),sph1(0,*),4,-4))
  q42=mean(spher_harm(sph1(1,*),sph1(0,*),4,-3))
  q43=mean(spher_harm(sph1(1,*),sph1(0,*),4,-2))
  q44=mean(spher_harm(sph1(1,*),sph1(0,*),4,-1))
  q45=mean(spher_harm(sph1(1,*),sph1(0,*),4,0))
  q46=mean(spher_harm(sph1(1,*),sph1(0,*),4,1))
  q47=mean(spher_harm(sph1(1,*),sph1(0,*),4,2))
  q48=mean(spher_harm(sph1(1,*),sph1(0,*),4,3))
  q49=mean(spher_harm(sph1(1,*),sph1(0,*),4,4))
  q81=mean(spher_harm(sph1(1,*),sph1(0,*),8,-8))
  q82=mean(spher_harm(sph1(1,*),sph1(0,*),8,-7))
  q83=mean(spher_harm(sph1(1,*),sph1(0,*),8,-6))
  q84=mean(spher_harm(sph1(1,*),sph1(0,*),8,-5))
  q85=mean(spher_harm(sph1(1,*),sph1(0,*),8,-4))
  q86=mean(spher_harm(sph1(1,*),sph1(0,*),8,-3))
  q87=mean(spher_harm(sph1(1,*),sph1(0,*),8,-2))
  q88=mean(spher_harm(sph1(1,*),sph1(0,*),8,-1))
  q89=mean(spher_harm(sph1(1,*),sph1(0,*),8,0))
  q810=mean(spher_harm(sph1(1,*),sph1(0,*),8,1))
  q811=mean(spher_harm(sph1(1,*),sph1(0,*),8,2))
  q812=mean(spher_harm(sph1(1,*),sph1(0,*),8,3))
  q813=mean(spher_harm(sph1(1,*),sph1(0,*),8,4))
  q814=mean(spher_harm(sph1(1,*),sph1(0,*),8,5))
  q815=mean(spher_harm(sph1(1,*),sph1(0,*),8,6))
  q816=mean(spher_harm(sph1(1,*),sph1(0,*),8,7))
  q817=mean(spher_harm(sph1(1,*),sph1(0,*),8,8))

  
  qq6m(0,j)=q61
  qq6m(1,j)=q62
  qq6m(2,j)=q63
  qq6m(3,j)=q64
  qq6m(4,j)=q65
  qq6m(5,j)=q66
  qq6m(6,j)=q67
  qq6m(7,j)=q68
  qq6m(8,j)=q69
  qq6m(9,j)=q610
  qq6m(10,j)=q611
  qq6m(11,j)=q612
  qq6m(12,j)=q613
  
  qq8m(0,j)=q81
  qq8m(1,j)=q82
  qq8m(2,j)=q83
  qq8m(3,j)=q84
  qq8m(4,j)=q85
  qq8m(5,j)=q86
  qq8m(6,j)=q87
  qq8m(7,j)=q88
  qq8m(8,j)=q89
  qq8m(9,j)=q810
  qq8m(10,j)=q811
  qq8m(11,j)=q812
  qq8m(12,j)=q813
  qq8m(13,j)=q814
  qq8m(14,j)=q815
  qq8m(15,j)=q816
  qq8m(16,j)=q817

  qq4m(0,j)=q41
  qq4m(1,j)=q42
  qq4m(2,j)=q43
  qq4m(3,j)=q44
  qq4m(4,j)=q45
  qq4m(5,j)=q46
  qq4m(6,j)=q47
  qq4m(7,j)=q48
  qq4m(8,j)=q49
  
  q4[j]=sqrt(4*(!pi)/9)*norm(qq4m[*,j],lnorm=2)
  q6[j]=sqrt(4*(!pi)/13)*norm(qq6m[*,j],lnorm=2)
  q8[j]=sqrt(4*(!pi)/17)*norm(qq8m[*,j],lnorm=2)  
 endif
endfor
result=[[q4],[q6],[q8]]
endtime=systime(/second)
print,'running time',endtime-start
return,result
end


function cal_bondorder,qq6m,neigh,i,dc=dc
if (not keyword_set(dc)) then dc=0.7
q6m1=sqrt(total((abs(qq6m[*,i]))^2))
q6mw=sqrt(total((abs(qq6m[*,neigh[1:neigh[0]]]))^2,1))  
w1=neigh[1:neigh[0]]
qiqj01=(qq6m(0,i)*conj(qq6m(0,w1)))+(qq6m(1,i)*conj(qq6m(1,w1)))+(qq6m(2,i)*conj(qq6m(2,w1)))$
+(qq6m(3,i)*conj(qq6m(3,w1)))+(qq6m(4,i)*conj(qq6m(4,w1)))+(qq6m(5,i)*conj(qq6m(5,w1)))+$
(qq6m(6,i)*conj(qq6m(6,w1)))+(qq6m(7,i)*conj(qq6m(7,w1)))+(qq6m(8,i)*conj(qq6m(8,w1)))+$
(qq6m(9,i)*conj(qq6m(9,w1)))+(qq6m(10,i)*conj(qq6m(10,w1)))+(qq6m(11,i)*(qq6m(11,w1)))+$
(qq6m(12,i)*conj(qq6m(12,w1)))
qiqj02=real_part(qiqj01)/(q6m1*q6mw)
ww=where(qiqj02[0,*] gt 0.70,nsolid)
return,nsolid
end


function cal_q6_course_grain,qq6m,neigh,i,q6m1_grain=q6m1_grain
w1=neigh[1:neigh[0]]
if neigh[0] eq 1 then begin
 q6m1_grain=(qq6m[*,w1]+qq6m[*,i])/(neigh[0]+1)
endif
if neigh[0] gt 1 then begin
 q6m1_grain=(total(qq6m[*,w1],2)+qq6m[*,i])/(neigh[0]+1)
endif
q6_course_grain=sqrt(4.0*!pi/13)*norm(q6m1_grain,lnorm=2)
return,q6_course_grain
end


function cal_q4_course_grain,qq4m,neigh,i,q4m1_grain=q4m1_grain
w1=neigh[1:neigh[0]]
if neigh[0] eq 1 then begin 
 q4m1_grain=(qq4m[*,w1]+qq4m[*,i])/(neigh[0]+1)
endif
if neigh[0] gt 1 then begin
 q4m1_grain=(total(qq4m[*,w1],2)+qq4m[*,i])/(neigh[0]+1)
endif
q4_course_grain=sqrt(4.0*!pi/9)*norm(q4m1_grain,lnorm=2)
return,q4_course_grain
end

function cal_q8_course_grain,qq8m,neigh,i,q8m1_grain=q8m1_grain
w1=neigh[1:neigh[0]]
if neigh[0] eq 1 then begin 
 q8m1_grain=(qq8m[*,w1]+qq8m[*,i])/(neigh[0]+1)
endif
if neigh[0] gt 1 then begin
 q8m1_grain=(total(qq8m[*,w1],2)+qq8m[*,i])/(neigh[0]+1)
endif
q8_course_grain=sqrt(4.0*!pi/17)*norm(q8m1_grain,lnorm=2)
return,q8_course_grain
end

function cal_w6,qq6m,qq6m_grain,i,wigner6
wig602=complexarr(13,13,13)
wig603=complexarr(13,13,13)
m01=[-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6]
for l=0,12 do begin
 for m=0,12 do begin
  for n=0,12 do begin
   if m01[l]+m01[m]+m01[n] eq 0 then begin
    wig601=wigner6[l,m,n]
    wig602[l,m,n]=wig601*qq6m_grain[l,i]*qq6m_grain[m,i]*qq6m_grain[n,i]
    wig603[l,m,n]=wig601*qq6m[l,i]*qq6m[m,i]*qq6m[n,i]
   endif
  endfor
 endfor
endfor
wig66=real_part(total(wig602))
ym6=(total((abs(qq6m_grain[*,i]))^2))^1.5
wig66=wig66/ym6
wig6=real_part(total(wig603))
ym61=(total((abs(qq6m[*,i]))^2))^1.5
wig6=wig6/ym61
result=[wig66,wig6]
return,result
end

function cal_w4,qq4m,qq4m_grain,i,wigner4
wig402=complexarr(9,9,9)
wig403=complexarr(9,9,9)
mm01=[-4,-3,-2,-1,0,1,2,3,4]
for l=0,8 do begin
 for m=0,8 do begin
  for n=0,8 do begin

   if mm01[l]+mm01[m]+mm01[n] eq 0 then begin
    wig401=wigner4[l,m,n]
    wig402[l,m,n]=wig401*qq4m_grain[l,i]*qq4m_grain[m,i]*qq4m_grain[n,i]
    wig403[l,m,n]=wig401*qq4m[l,i]*qq4m[m,i]*qq4m[n,i]
   endif
  endfor
 endfor
endfor
wig44=real_part(total(wig402))
ym4=(total((abs(qq4m_grain[*,i]))^2))^1.5
wig44=wig44/ym4
wig4=real_part(total(wig403))
ym41=(total((abs(qq4m[*,i]))^2))^1.5
wig4=wig4/ym41
result=[wig44,wig4]
return,result
end

function cal_w8,qq8m,qq8m_grain,i,wigner8
wig802=complexarr(17,17,17)
wig803=complexarr(17,17,17)
mm01=[-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8]
for l=0,16 do begin
 for m=0,16 do begin
  for n=0,16 do begin
   if mm01[l]+mm01[m]+mm01[n] eq 0 then begin
    wig801=wigner8[l,m,n]
    wig802[l,m,n]=wig801*qq8m_grain[l,i]*qq8m_grain[m,i]*qq8m_grain[n,i]
    wig803[l,m,n]=wig801*qq8m[l,i]*qq8m[m,i]*qq8m[n,i]
   endif
  endfor
 endfor
endfor
wig88=real_part(total(wig802))
ym8=(total((abs(qq8m_grain[*,i]))^2))^1.5
wig88=wig88/ym8
wig8=real_part(total(wig803))
ym81=(total((abs(qq8m[*,i]))^2))^1.5
wig8=wig8/ym81
result=[wig88,wig8]
return,result
end



function cal_wigner6
wigner=dblarr(13,13,13)
m01=[-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6]
for l=0,12 do begin
 for m=0,12 do begin
  for n=0,12 do begin
   if m01[l]+m01[m]+m01[n] eq 0 then begin
    wig601=wigner_threej(6,6,6,m01[l],m01[m],m01[n])
    wigner[l,m,n]=wig601
   endif
  endfor
 endfor
endfor
return,wigner
end


function cal_wigner4
wigner=dblarr(9,9,9)
mm01=[-4,-3,-2,-1,0,1,2,3,4]
for l=0,8 do begin
 for m=0,8 do begin
  for n=0,8 do begin
   if mm01[l]+mm01[m]+mm01[n] eq 0 then begin
    wig601=wigner_threej(4,4,4,mm01[l],mm01[m],mm01[n])
    wigner[l,m,n]=wig601
   endif
  endfor
 endfor
endfor
return,wigner
end

function cal_wigner8
wigner=dblarr(17,17,17)
mm01=[-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8]
for l=0,16 do begin
 for m=0,16 do begin
  for n=0,16 do begin
   if mm01[l]+mm01[m]+mm01[n] eq 0 then begin
    wig601=wigner_threej(8,8,8,mm01[l],mm01[m],mm01[n])
    wigner[l,m,n]=wig601
   endif
  endfor
 endfor
endfor
return,wigner
end

function bondvoi,trbb,dr=dr,track=track,method=method,nosplit=nosplit,bondmax=bondmax,qq6m=qq6m
if not keyword_set(method) then method=1
ncol=n_elements(trbb[*,0])
if keyword_set(track) then ncol--
tmin=min(trbb[ncol-1,*])
tmax=max(trbb[ncol-1,*])
totalparticlenum=n_elements(trbb[0,*])
result=fltarr(18,totalparticlenum)
for s=tmin,tmax do begin
 print,s
 wt=where(trbb[ncol-1,*] eq s)
 trb=trbb[*,wt]
 particlenum=n_elements(trb[0,*])
 q6=fltarr(particlenum)
 q4=fltarr(particlenum)
 q8=fltarr(particlenum)
 q6_course_grain=fltarr(particlenum)
 q4_course_grain=fltarr(particlenum)
 q8_course_grain=fltarr(particlenum)
 solidbond=fltarr(particlenum)
 qq6m=complexarr(13,particlenum)
 qq4m=complexarr(9,particlenum)
 qq8m=complexarr(17,particlenum)
 qq6m_grain=complexarr(13,particlenum)
 qq4m_grain=complexarr(9,particlenum)
 qq8m_grain=complexarr(17,particlenum)
 w4=fltarr(2,particlenum)
 w6=fltarr(2,particlenum)
 w8=fltarr(2,particlenum)
 if method eq 1 then begin         ;主要是用voronoi的方法去找粒子的邻居的
  con=voronoicell_con(trb,v1=v1)  ;con 输出是一个【粒子数，201,2】的矩阵，其中【i,0:neighnum,0】 表示的是第i个中心粒子的邻居数目，以及邻居粒子的下标；【i,0:neighnum,1】 表示的是第i个中心粒子的vonronoi 的总面积，以及其与邻居粒子构成的面积
  for i=0L,particlenum-1 do begin
   neighnum=con[i,0,0]
   totalarea=con[i,0,1]
   dx=trb[0,con[i,1:neighnum],0]-trb[0,i]
   dy=trb[1,con[i,1:neighnum],0]-trb[1,i]
   dz=trb[2,con[i,1:neighnum],0]-trb[2,i]
   c1=[dx,dy,dz]
   area=con[i,0:neighnum,1]
   q6[i]=cal_q6(c1,area,q6m=q6m)   ;计算得到的q6已经是不含取向信息了，只含强度信息，q6m是含有取向信息的。
   q4[i]=cal_q4(c1,area,q4m=q4m)
   q8[i]=cal_q8(c1,area,q8m=q8m)
   qq6m[*,i]=q6m
   qq4m[*,i]=q4m 
   qq8m[*,i]=q8m
  endfor                     
 endif
 if method eq 2 then begin
  result1= q4q6_origin(trb,deltar=dr,con=con,qq6m=qq6m,qq4m=qq4m,qq8m=qq8m,bondnum=bondnum,nosplit=nosplit,bondmax=bondmax) ;用距离的cutoff的值取找粒子的邻居的。
  q4=result1[*,0]
  q6=result1[*,1]
  q8=result1[*,2]
 endif
 for i=0L,particlenum-1 do begin
  neighnum=con[i,0,0]                          
  if neighnum eq 0 then continue                                                ;;;
  solidbond[i]=cal_bondorder(qq6m,con[i,*,0],i)
  q6_course_grain[i]=cal_q6_course_grain(qq6m,con[i,*,0],i,q6m1_grain=q6m1_grain) ;做coarse grain 的时候是先将中心粒子和邻居粒子的qlm做平均，然后在就算q4,q6,q8
  q4_course_grain[i]=cal_q4_course_grain(qq4m,con[i,*,0],i,q4m1_grain=q4m1_grain)
  q8_course_grain[i]=cal_q8_course_grain(qq8m,con[i,*,0],i,q8m1_grain=q8m1_grain)
  qq4m_grain[*,i]=q4m1_grain
  qq6m_grain[*,i]=q6m1_grain
  qq8m_grain[*,i]=q8m1_grain
 endfor
 wigner6=cal_wigner6()
 wigner4=cal_wigner4()
 wigner8=cal_wigner8()
 for i=0L,particlenum-1 do begin
  neighnum=con[i,0,0]  
  if neighnum eq 0 then continue
  w6[*,i]=cal_w6(qq6m,qq6m_grain,i,wigner6)
  w4[*,i]=cal_w4(qq4m,qq4m_grain,i,wigner4)
  w8[*,i]=cal_w8(qq8m,qq8m_grain,i,wigner8)
 endfor
 result[0:2,wt]=trb[0:2,*]
 result[3,wt]=solidbond
 result[4,wt]=q4_course_grain  ;同样旋转不变量，但是qlm进行了与周围邻居粒子的一次coarse grain ，
 result[5,wt]=q6_course_grain
 result[6,wt]=q8_course_grain
 result[7,wt]=w4[0,*]
 result[8,wt]=w6[0,*]
 result[9,wt]=w8[0,*]
 result[10,wt]=q4
 result[11,wt]=q6  ;旋转不变量，没有coarse grain 的量
 result[12,wt]=q8
 result[13,wt]=w4[1,*]
 result[14,wt]=w6[1,*]
 result[15,wt]=w8[1,*]
 result[16,wt]=con[*,0,0]
 if method eq 2 then result[16,wt]=bondnum
 result[17,wt]=trb[ncol-1,*]
endfor
return,result
end