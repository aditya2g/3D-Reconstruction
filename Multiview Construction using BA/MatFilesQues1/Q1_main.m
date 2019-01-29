load('cube_imgs.mat');
load('projMatrices.mat');
img_pts = {};
proj=projMatrices;
N = 8;
for i=1:N
    img_pts{i,1} = squeeze(image_pts(i,:,:))';
end
sz = size(img_pts{1},1);
pts = zeros(N,4);
P = zeros(N,3,4);
for j=1:sz
    A = zeros(16,4);
    for i = 1: N
        P(i,1,:)=proj{i}(1,:);
        P(i,2,:)=proj{i}(2,:);
        P(i,3,:)=proj{i}(3,:);
        x1=img_pts{i}(j,1);
        x2=img_pts{i}(j,2);
        A(2*i-1,:) =x1*P(i,3,:) - P(i,1,:);
        A(2*i,:)=x2*P(i,3,:) - P(i,2,:);
    end
    [U,D,V] = svd(A);
    pts(j,:) = V(:,end);
    pts(j,:) = pts(j,:)/pts(j,4);
end
for i = 1:sz
    scatter3(pts(i,1),pts(i,2),pts(i,3),'o','b','filled');
    title('reconstructed cube');
    xlabel('x-axis');
    ylabel('y-axis');
    zlabel('z-axis');
    hold on;
end
hold off;