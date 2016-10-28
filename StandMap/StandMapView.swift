import UIKit
import SnapKit
import OAStackView

class StandMapView: UIView, StandMapHotspotLayerViewDataSource {
    
    var hotspots = [Hotspot]()
    var titleLabel: UILabel = UILabel()
    var standMapImage: UIImageView = UIImageView()
    var hotspotLayerView: StandMapHotspotLayerView = StandMapHotspotLayerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(standMap: StandMap, hotspots: [Hotspot]) {
        titleLabel.text = standMap.title
        standMapImage.image = UIImage(named: standMap.mapImage)
        self.hotspots = hotspots
    }
    
    func reloadData() {
        hotspotLayerView.reloadData()
    }

    func setupSubviews() {
        
        self.backgroundColor = UIColor.blackColor()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        standMapImage.translatesAutoresizingMaskIntoConstraints = false
        hotspotLayerView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        titleLabel.numberOfLines = 0
        standMapImage.contentMode = .ScaleAspectFit
        
        addSubview(titleLabel)
        addSubview(standMapImage)
        addSubview(hotspotLayerView)
        
        titleLabel.snp_makeConstraints { make in
            make.topMargin.equalTo(snp_topMargin).multipliedBy(4)
            make.leadingMargin.equalTo(snp_leadingMargin).inset(15)
            make.trailingMargin.equalTo(snp_trailingMargin).inset(15)
        }
        
        standMapImage.snp_makeConstraints { make in
            make.center.equalTo(snp_center)
            make.width.equalTo(snp_width)
            make.height.equalTo(snp_width).multipliedBy(0.6946)
        }
        
        hotspotLayerView.snp_makeConstraints { make in
            make.edges.equalTo(standMapImage.snp_edges)
            make.center.equalTo(snp_center)
        }
            
        hotspotLayerView.dataSource = self
    }
    
    func numberOfHotspots(standMapHotspotLayerView: StandMapHotspotLayerView) -> Int {
        return hotspots.count
    }
    
    func hotspotViewForIndex(index: Int, inStandMapHotspotLayerView layerView: StandMapHotspotLayerView) -> (UIImageView, OAStackView) {
        let hotspot = hotspots[index]
        let hotspotView = UIImageView(image: UIImage(named: hotspot.image))
        let width = standMapImage.frame.width * 0.1
        hotspotView.frame = CGRect(x: 0, y: 0, width: width, height: width)
        var x = standMapImage.frame.width * CGFloat(hotspot.hotspotXCoordinate)
        var y = standMapImage.frame.height * CGFloat(hotspot.hotspotYCoordinate)
        hotspotView.center = CGPoint(x: x, y: y)
    
        let labelView: UILabel = UILabel()
        labelView.frame = CGRectZero
        labelView.text = hotspot.title
        labelView.sizeToFit()
        labelView.font = UIFont(name: "Helvetica", size: 13)
        labelView.textColor = UIColor.whiteColor()
        labelView.textAlignment = .Center
        labelView.numberOfLines = 0
        
        let textView: UILabel = UILabel()
        textView.frame = CGRectZero
        textView.text = hotspot.text
        textView.sizeToFit()
        textView.font = UIFont(name: "Helvetica", size: 11)
        textView.textColor = UIColor.whiteColor()
        textView.textAlignment = .Center
        textView.numberOfLines = 0
        
        let stackView: OAStackView = OAStackView()
        x = standMapImage.frame.width * CGFloat(hotspot.titleXCoordinate)
        y = standMapImage.frame.height * CGFloat(hotspot.titleYCoordinate)
        stackView.frame = CGRect(x: x, y: y, width: 150, height: 30)
        stackView.addArrangedSubview(labelView)
        stackView.addArrangedSubview(textView)
        stackView.axis = .Vertical
        stackView.distribution = .FillEqually
        
        return (hotspotView, stackView)
    }

}
