classdef Class_hexahedron
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        N;
        cube;
        p_Max;
        p_Lap;
        k;
        material=0;
        face_num=[1:6];
        per;
    end
    
    properties(Dependent)
        NO;
        xm;
        neib0;
        neib;
        
        I_Max;
        I_Lap;
        
        Gauss_body;
        Gauss_face;
        
        Nor;
        
    end
    
    methods
        function td=Class_hexahedron(N,cube,p_Max,p_Lap,per,k,material)
            td.N=N;
            td.cube=cube;
            td.p_Max=p_Max;
            td.p_Lap=p_Lap;
            td.per=per;        
            td.k=k;
            td.material=material;
        end
    end
    
    methods
        
        function NO=get.NO(obj)
            i=obj.cube(1);
            j=obj.cube(2);
            k=obj.cube(3);
            N=obj.N;
            NO=(i-1)*N^2+(j-1)*N+k;
        end
        
        function xm=get.xm(obj)
            h=1/obj.N;
            mm=obj.cube-[1,1,1]/2;
            xm=mm*h;
        end
        
        function neib0=get.neib0(obj)
            N=obj.N;
            pp=[-1,0,0;
                1,0,0;
                0,-1,0;
                0,1,0;
                0,0,-1;
                0,0,1;];
            cc=[obj.cube;
                obj.cube;
                obj.cube;
                obj.cube;
                obj.cube;
                obj.cube;];
            nn=cc+pp;
            neib_dir=nn;
            neib_per=nn;
            
            for i=1:6
                for j=1:3
                    %%%%% Dir
                    if neib_dir(i,j)==0|neib_dir(i,j)==N+1
                        neib_dir(i,j)=0;
                    end
                    %%%%%  Per
                    if neib_per(i,j)==0
                        neib_per(i,j)=N;
                    elseif neib_per(i,j)==N+1
                        neib_per(i,j)=1;
                    end
                    %%%%%%
                end
            end
            
            for i=1:6
                neib_P(i)=(neib_per(i,1)-1)*N^2+(neib_per(i,2)-1)*N+neib_per(i,3);
                
                if neib_dir(i,1)*neib_dir(i,2)*neib_dir(i,3)==0
                    neib_D(i)=0;
                else
                    neib_D(i)=(neib_dir(i,1)-1)*N^2+(neib_dir(i,2)-1)*N+neib_dir(i,3);
                end
            end
            
            neib0.Dir=neib_D;
            neib0.Per=neib_P;
        end
        
        function neib=get.neib(obj)
            if obj.per==1
                neib=obj.neib0.Dir;
            elseif obj.per==2
                neib=obj.neib0.Per;
            end
        end
        
        function Nor=get.Nor(obj)
            Nor=[-1,0,0;
                1,0,0;
                0,-1,0;
                0,1,0;
                0,0,-1;
                0,0,1;];
        end
        
        function I_Max=get.I_Max(obj)
            I_Max=[1:obj.p_Max]+(obj.NO-1)*obj.p_Max;
        end
        
        function I_Lap=get.I_Lap(obj)
            I_Lap=[1:obj.p_Lap]+(obj.NO-1)*obj.p_Lap;
        end
        
        function Gauss_body=get.Gauss_body(obj)
            gp=[-0.466234757101576013906150777246997304567,
                -0.330604693233132256830699797509952673503,
                -0.119309593041598454315250860840355967709,
                0.119309593041598454315250860840355967709,
                0.330604693233132256830699797509952673503,
                0.466234757101576013906150777246997304567];
            wg=[1.7132449237916972e-01/2.0,
                3.6076157304813861e-01/2.0,
                4.6791393457269098e-01/2.0,
                4.6791393457269098e-01/2.0,
                3.6076157304813861e-01/2.0,
                1.7132449237916972e-01/2.0];
            gg=max(size(wg));
            h=1/obj.N;
            gp=gp*h;
            wg=wg*h;
            
            X=gp+obj.xm(1);
            Y=gp+obj.xm(2);
            Z=gp+obj.xm(3);
            
            nn=0;
            
            Gb.point=zeros(gg^3,3);
            Gb.weight=zeros(gg^3,1);
            Gb.N=gg^3;
            for i=1:gg
                for j=1:gg
                    for k=1:gg
                        nn=nn+1;
                        Gb.point(nn,:)=[X(i),Y(j),Z(k)];
                        Gb.weight(nn)=wg(i)*wg(j)*wg(k);
                    end
                end
            end
            
            Gauss_body=Gb;
            
        end
        
        function Gauss_face=get.Gauss_face(obj)
            gp=[-0.466234757101576013906150777246997304567,
                -0.330604693233132256830699797509952673503,
                -0.119309593041598454315250860840355967709,
                0.119309593041598454315250860840355967709,
                0.330604693233132256830699797509952673503,
                0.466234757101576013906150777246997304567];
            wg=[1.7132449237916972e-01/2.0,
                3.6076157304813861e-01/2.0,
                4.6791393457269098e-01/2.0,
                4.6791393457269098e-01/2.0,
                3.6076157304813861e-01/2.0,
                1.7132449237916972e-01/2.0];
            gg=max(size(wg));
            h=1/obj.N;
            gp=gp*h;
            wg=wg*h;
            
            X=gp+obj.xm(1);
            Y=gp+obj.xm(2);
            Z=gp+obj.xm(3);
            
            xyz=[-h,h]/2;
            Xb=xyz+obj.xm(1);
            Yb=xyz+obj.xm(2);
            Zb=xyz+obj.xm(3);
            
            for i=1:6
                Gf(i).point=zeros(gg^2,3);
                Gf(i).weight=zeros(gg^2,1);
                Gf(i).N=gg^2;
            end
            
            %%%%%%%%%%%%%%%% X
            nn=0;
            point=zeros(gg^2,2);
            weight=zeros(gg^2,1);
            for i=1:gg
                for j=1:gg
                    nn=nn+1;
                    point(nn,:)=[Y(i),Z(j)];
                    weight(nn)=wg(i)*wg(j);
                end
            end
            Gf(1).point=[ones(gg^2,1)*Xb(1),point];
            Gf(1).weight=weight;
            
            Gf(2).point=[ones(gg^2,1)*Xb(2),point];
            Gf(2).weight=weight;
            
            %%%%%%%%%%%%%%%% Y
            nn=0;
            point=zeros(gg^2,2);
            weight=zeros(gg^2,1);
            for i=1:gg
                for j=1:gg
                    nn=nn+1;
                    point(nn,:)=[X(i),Z(j)];
                    weight(nn)=wg(i)*wg(j);
                end
            end
            Gf(3).point=[point(:,1),ones(gg^2,1)*Yb(1),point(:,2)];
            Gf(3).weight=weight;
            
            Gf(4).point=[point(:,1),ones(gg^2,1)*Yb(2),point(:,2)];
            Gf(4).weight=weight;
            
            %%%%%%%%%%%%%%%% Y
            nn=0;
            point=zeros(gg^2,2);
            weight=zeros(gg^2,1);
            for i=1:gg
                for j=1:gg
                    nn=nn+1;
                    point(nn,:)=[X(i),Y(j)];
                    weight(nn)=wg(i)*wg(j);
                end
            end
            Gf(5).point=[point,ones(gg^2,1)*Zb(1)];
            Gf(5).weight=weight;
            
            Gf(6).point=[point,ones(gg^2,1)*Zb(2)];
            Gf(6).weight=weight;
            
            Gauss_face=Gf;
        end
    end
    
end




