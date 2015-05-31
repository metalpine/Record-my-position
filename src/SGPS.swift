import Foundation
import CoreLocation


enum Accuracy
{
    case High, Medium, Low
}

@objc class SGPS : NSObject, CLLocationManagerDelegate
{
    private let _GPS_IS_ON_KEY = "gps_is_on"
    private let _KEY_SAVE_SINGLE_POSITION = "save_single_positions"

    static private let cInstance: SGPS = SGPS()

    private var mSaveAllPositions = false
    private var mGpsIsOn = false
    private var mManager: CLLocationManager
    private var mAccuracy: Accuracy

    static func get() -> SGPS
    {
        return cInstance
    }

    override init()
    {
        println("Initializing SGPS")
        mManager = CLLocationManager()
        //assert(nil !== mManager) TODO: Why does the check fail?
        mAccuracy = .High
        super.init()

        // Set no filter and try to get the best accuracy possible.
        mManager.distanceFilter = kCLDistanceFilterNone
        mManager.desiredAccuracy = kCLLocationAccuracyBest
        mManager.delegate = self

        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.boolForKey(_GPS_IS_ON_KEY) {
            start()
        }
        mSaveAllPositions = defaults.boolForKey(_KEY_SAVE_SINGLE_POSITION)
    }

    deinit {
        stop()
        //mManager = nil
    }

    var saveAllPositions: Bool {
        get { return mSaveAllPositions }
        set {
            mSaveAllPositions = newValue
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(newValue, forKey:_KEY_SAVE_SINGLE_POSITION)
            defaults.synchronize()
        }
    }

    var gpsIsOn: Bool {
        get { return mGpsIsOn }
        set {
            mGpsIsOn = newValue
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(newValue, forKey:_GPS_IS_ON_KEY)
            defaults.synchronize()
        }
    }

    func start()
    {
        println("Starting!")
    }

    func stop()
    {
        println("Stopping")
    }
}