# For myself
#apt install -y emacs

# Build library
#pushd .
cd /scene_graph_benchmark
python setup.py build develop
#popd

# For dataset
if [ ! -f "./datasets/visualgenome/VG-SGG-dicts-vgoi6-clipped.json" ]; then
    wget https://penzhanwu2.blob.core.windows.net/sgg/sgg_benchmark/vinvl_model_zoo/VG-SGG-dicts-vgoi6-clipped.json -P ./datasets/visualgenome/
fi

# Doesn't see scene_graph_benchmark as a module(?)

if [ ! -d "./pretrained_model" ]; then
    mkdir pretrained_model
fi
if [ ! -f "./vinvl_vg_x152c4.pth" ]; then
    wget https://penzhanwu2.blob.core.windows.net/sgg/sgg_benchmark/vinvl_model_zoo/vinvl_vg_x152c4.pth -P ./pretrained_model/
fi

if [ ! -f "./pretrained_model/RX152FPN_reldn_oi_best.pth" ]; then
    wget https://penzhanwu2.blob.core.windows.net/sgg/sgg_benchmark/sgg_model_zoo/sgg_oi_vrd_model_zoo/RX152FPN_reldn_oi_best.pth -P ./pretrained_model/
fi    

## Check that tutorial examples work
# Object detection (worked)
python tools/demo/demo_image.py --config_file sgg_configs/vgattr/vinvl_x152c4.yaml --img_file demo/woman_fish.jpg --save_file output/woman_fish_x152c4.obj.jpg MODEL.WEIGHT pretrained_model/vinvl_vg_x152c4.pth MODEL.ROI_HEADS.NMS_FILTER 1 MODEL.ROI_HEADS.SCORE_THRESH 0.2 TEST.IGNORE_BOX_REGRESSION False

# Attributes (worked)
python tools/demo/demo_image.py --config_file sgg_configs/vgattr/vinvl_x152c4.yaml --img_file demo/woman_fish.jpg --save_file output/woman_fish_x152c4.attr.jpg --visualize_attr MODEL.WEIGHT pretrained_model/vinvl_vg_x152c4.pth MODEL.ROI_HEADS.NMS_FILTER 1 MODEL.ROI_HEADS.SCORE_THRESH 0.2 TEST.IGNORE_BOX_REGRESSION False

# 
python tools/demo/demo_image.py --config_file sgg_configs/vrd/R152FPN_vrd_reldn.yaml --img_file demo/1024px-Gen_Robert_E_Lee_on_Traveler_at_Gettysburg_Pa.jpg --save_file output/1024px-Gen_Robert_E_Lee_on_Traveler_at_Gettysburg_Pa.reldn_relation.jpg --visualize_relation MODEL.ROI_RELATION_HEAD.DETECTOR_PRE_CALCULATED False
