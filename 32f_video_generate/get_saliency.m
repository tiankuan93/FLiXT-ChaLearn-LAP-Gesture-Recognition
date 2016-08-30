function sal_img = get_saliency(img)
    sal_img = saliency(img);
    sal_img = sal_img/max(max(sal_img));
end