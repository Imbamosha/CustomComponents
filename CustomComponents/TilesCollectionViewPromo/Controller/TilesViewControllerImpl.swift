//
//  TilesViewControllerImpl.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 26.03.2021.
//


import UIKit

class TilesViewControllerImpl: UIViewController {
    
    //MARK: - UIComponents
    private weak var tilesView: TilesView!
    
    //MARK: - Layouts
    private let tilesViewLayout = TilesViewLayouts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        display(with: .loading)
        
        setupMock()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationBar()
        self.extendedLayoutIncludesOpaqueBars = true
        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    init() {
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
}

//MARK: - Interface
extension TilesViewControllerImpl: TilesViewController {
    
    func display(with state: TilesViewControllerState) {
        switch state {
        case .loading:
            break
        case let .viewModel(model):
            self.tilesView.update(with: model)
        }
    }
    
}

//MARK: - Private methods
extension TilesViewControllerImpl {
    
    private func setupSubviews() {
        setupPostcardsView()
    }
    
    private func setupPostcardsView() {
        let tiles = TilesViewImpl()
        
        tiles.delegate = self
        
        tilesView = tiles
        view.addSubview(tiles)
        tilesViewLayout.initial(tiles)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupMock() {
        let tilesViewModel = TilesViewModel(postcards: [
                                                TileViewModel(id: "0", state: .front, title: "Кошка", mainImage: "cat", description: "Ко́шка, или дома́шняя ко́шка — домашнее животное, одно из наиболее популярных (наряду с собакой) «животных-компаньонов. С точки зрения научной систематики, домашняя кошка — млекопитающее семейства кошачьих отряда хищных. Ранее домашнюю кошку нередко рассматривали как отдельный биологический вид. С точки зрения современной биологической систематики домашняя кошка (Felis silvestris catus) является подвидом лесной кошки (Felis silvestris)."),
                                                TileViewModel(id: "1", state: .front, title: "Собака", mainImage: "dog", description: "Соба́ка (лат. Canis lupus familiaris) — домашнее животное, одно из наиболее популярных (наряду с кошкой) животных-компаньонов. Первоначально домашняя собака была выделена в отдельный биологический вид (лат. Canis familiaris) Линнеем в 1758 году, в 1993 году реклассифицирована Смитсоновским институтом и Американской ассоциацией териологов в подвид волка (Canis lupus)."),
                                                TileViewModel(id: "2", state: .front, title: "Лиса", mainImage: "fox", description: "Лиси́ца — общее название нескольких видов млекопитающих семейства псовые. Только 10 видов этой группы относят к роду собственно лисиц (лат. Vulpes). Наиболее известный и распространённый представитель — обыкновенная лисица (Vulpes vulpes). Лисицы встречаются в фольклоре многих народов по всему миру."),
                                                TileViewModel(id: "3", state: .front, title: "Лев", mainImage: "lion", description: "Лев (лат. Panthera leo) — вид хищных млекопитающих, один из пяти представителей рода пантер (Panthera), относящегося к подсемейству больших кошек (Pantherinae) в составе семейства кошачьих (Felidae). Наряду с тигром — самая крупная из ныне живущих кошек, масса некоторых самцов может достигать 250 кг. Трудно сказать достоверно, массивнее ли крупнейшие подвиды льва, чем крупнейшие подвиды тигров. Связано это с тем, что исторические очень крупные веса амурских тигров в большинстве своём признаны недостаточно достоверными. Достаточными данными о размерах и массе представителей крупнейших подвидов льва (например, барбарийском) наука не располагает. Что касается живущих в неволе животных, они часто являют собой смешение разных подвидов. Существует мнение, что львы в неволе несколько превышают тигров в размерах и массе, так же как и обратное ему."),
                                                TileViewModel(id: "4", state: .front, title: "Сова", mainImage: "owl", description: "Совообра́зные (лат. Strigiformes) — отряд хищных птиц, включающий более 200 крупных и средней величины видов, в основном ночных птиц, распространённых во всех странах мира. В отряде два современных семейства: совиные, или настоящие совы, а также сипуховые. Краткая характеристика: крупная голова, большие круглые глаза спереди головы, клюв короткий, хищный. Охотится ночью, оперение мягкое, полёт бесшумный, когти длинные и острые, окрас маскирующий."),
                                                TileViewModel(id: "4", state: .front, title: "Свинья", mainImage: "pig", description: "Дома́шняя свинья́ (лат. Sus scrofa domesticus) — крупное парнокопытное, подвид кабана рода Кабаны, одомашненный человеком около 7 тыс. лет назад (по некоторым исследованиям — значительно раньше) и распространённый главным образом в странах Запада, в Восточной Азии и в Океании. Одичавшие свиньи (рейзорбеки) встречаются в Северной Америке, в Австралии и в Новой Зеландии. Длина тела составляет от 0,9 до 1,8 м, взрослая особь весит от 50 до 150 кг. По сравнению с другими парнокопытными, которые чаще бывают растительноядными, домашняя свинья всеядна, как и её предок, дикий кабан.")])
        display(with: .viewModel(tilesViewModel))
    }
    
}

extension TilesViewControllerImpl: TilesViewDelegate {
    
    func scrollDidEnd() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
}
