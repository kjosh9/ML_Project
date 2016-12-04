
function result = createImages(data)

    for i=1:size(data,1)

        im = reshape(data(i,:),32, 32, 3);

        imname = strcat('./Images/image', num2str(i), '.png');

        imwrite(im,imname);

    end

result = true;

