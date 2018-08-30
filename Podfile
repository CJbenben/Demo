platform :ios, '7.0'
target 'Demo' do
    
#AFNetworking
pod "AFNetworking", "~> 2.4.1"
#用法简单的下拉刷新框架
pod 'MJRefresh'
pod 'SDWebImage', '~>3.8'
pod 'Masonry'

pod 'AMap2DMap-NO-IDFA'
pod 'AMapSearch-NO-IDFA'
pod 'AMapLocation-NO-IDFA'

    abstract_target 'Tests' do
        #inherit! :search_paths
        target "DemoTests"
        target "DemoUITests"
        
        pod 'Quick'
        pod 'Nimble'
    end

end

