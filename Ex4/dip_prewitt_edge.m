%Natan Davidov 211685300, Nikolai Krokhmal 320717184

function edge_after_thresh = dip_prewitt_edge(img,thresh)
    G_px = [-1 0 1; -1 0 1; -1 0 1]/6;
    G_py = [1 1 1; 0 0 0; -1 -1 -1]/6;
    edge_x = conv2(img, G_px, "same");
    edge_y = conv2(img, G_py, "same");
    edge = sqrt(edge_x.^2 + edge_y.^2);
    edge_b = edge>thresh;
    edge_after_thresh = edge.*edge_b;
end