//
//  DetailViewController.swift
//  MyMovies
//
//  Created by Jurymar Colmenares on 12/03/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var movieTitle: String?
    var moviePosterPath: String?
    var movieOverview: String?
    var releaseDate: String?
    
    //Para presentar la imagen y los label
    var posterImageView: UIImageView!
    var titleLabel: UILabel!
    var overviewLabel: UILabel!
    var releaseDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Establecer el título del navigationItem
        navigationItem.title = "Detalle"
        
        view.backgroundColor = .white
        
        // Crear UIImageView para mostrar el póster
        posterImageView = UIImageView()
        posterImageView.contentMode = .scaleAspectFit
        
        // Configurar la imagen del póster si está disponible
        if let posterPath = moviePosterPath, let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            DispatchQueue.global().async {
                if let posterData = try? Data(contentsOf: posterURL) {
                    DispatchQueue.main.async {
                        self.posterImageView.image = UIImage(data: posterData)
                    }
                }
            }
        }
        
        // Crear el UILabel para mostrar el título
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = movieTitle
        
        // Crear el UILabel para mostrar la descripción
        overviewLabel = UILabel()
        overviewLabel.textAlignment = .justified
        overviewLabel.numberOfLines = 0 // Permite que el texto se muestre en varias líneas
        overviewLabel.text = movieOverview
        
        //Agregar fecha
        releaseDateLabel = UILabel()
        releaseDateLabel.textAlignment = .center
        releaseDateLabel.text = releaseDate
        
        // Agregar las vistas al controlador de vista
        view.addSubview(posterImageView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(releaseDateLabel)
        
        // Establecer las constraints
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Constraints para el UIImageView del póster
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            posterImageView.heightAnchor.constraint(equalToConstant: 200),
            
            // Constraints para el UILabel del título
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Constraints para el UILabel de la descripción
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            releaseDateLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 30), // Posición debajo del label de descripción
            releaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            releaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)

        ])
    }
}

