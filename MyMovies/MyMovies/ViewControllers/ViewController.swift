//
//  ViewController.swift
//  MyMovies
//
//  Created by Jurymar Colmenares on 11/03/24.
//

import UIKit
                      // Hereda clase   -implementa protocolo, no se heredan protocolos
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    //Declaro las propiedades de la clase 
    let reuseIdentifier = "MovieCell"
    var collectionView: UICollectionView!
    var movies = [Movie]()
    var filteredMovies = [Movie]()
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar el layout del collectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let itemWidth = (view.frame.width - layout.sectionInset.left - layout.sectionInset.right - layout.minimumInteritemSpacing) / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
        
        // Configurar el collectionView
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        view.addSubview(collectionView)
        
        // Configurar el searchBar
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        //llamo funcion addConstraints
        addConstraints()
        
        // Obtener datos de la API
        fetchMovies()
    }
    
    func fetchMovies() {
        let apiKey = "d4849d0d8592036d63a3e615d5439c28"
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error al obtener los datos:", error?.localizedDescription ?? "Unknown error")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MovieResult.self, from: data)
                self.movies = result.results
                self.filteredMovies = self.movies
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print("Error al decodificar los datos:", error.localizedDescription)
            }
        }.resume()
    }
    
    // UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMovies.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        let movie = filteredMovies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
    
    // UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = filteredMovies[indexPath.item]
        
        // Crear instancia de DetailViewController
        let detailViewController = DetailViewController()
        detailViewController.movieTitle = selectedMovie.title
        detailViewController.moviePosterPath = selectedMovie.posterPath
        detailViewController.movieOverview = selectedMovie.overview
        detailViewController.releaseDate = selectedMovie.releaseDate
        
        // Obtener el UINavigationController desde la propiedad navigationController
        show(detailViewController, sender: nil)
        // Presentar el DetailViewController
        //present(detailViewController, animated: true, completion: nil)
    }
    
    // UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        collectionView.reloadData()
    }

    func addConstraints() {
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //arriba topAnchor
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            //izquierda - inicio leadingAnchor
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            //derecha - fin trailingAnchor
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //searchBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            //abajo bottomAnchor
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 4),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


