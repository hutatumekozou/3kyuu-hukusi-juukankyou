import Foundation

enum QuizTopic: CaseIterable, Identifiable {
    case agingSociety
    case housingImportance
    case homeCareServices
    case elderlyHealth
    case disabilitySupport
    case barrierFreeDesign
    case welfareEquipment
    case housingImprovement
    case dailyLiving
    case communityDevelopment

    var id: String { fileName }

    var title: String {
        switch self {
        case .agingSociety:        return "少子高齢社会の現状と共生社会"
        case .housingImportance:   return "福祉住環境整備の重要性・必要性"
        case .homeCareServices:    return "在宅生活と介護サービス"
        case .elderlyHealth:       return "高齢者の健康と自立"
        case .disabilitySupport:   return "障害者の生活の不自由を克服する道"
        case .barrierFreeDesign:   return "バリアフリーとユニバーサルデザインを考える"
        case .welfareEquipment:    return "生活を支える福祉用具"
        case .housingImprovement:  return "住まいの整備のための基本技術"
        case .dailyLiving:         return "生活行為別に見る安全・安心・快適な住まい"
        case .communityDevelopment: return "安心して暮らせる住まいとまちづくり"
        }
    }

    var fileName: String {
        switch self {
        case .agingSociety:        return "category1_aging_society"
        case .housingImportance:   return "category2_housing_importance"
        case .homeCareServices:    return "category3_home_care_services"
        case .elderlyHealth:       return "category4_elderly_health"
        case .disabilitySupport:   return "category5_disability_support"
        case .barrierFreeDesign:   return "category6_barrier_free_design"
        case .welfareEquipment:    return "category7_welfare_equipment"
        case .housingImprovement:  return "category8_housing_improvement"
        case .dailyLiving:         return "category9_daily_living"
        case .communityDevelopment: return "category10_community_development"
        }
    }
}