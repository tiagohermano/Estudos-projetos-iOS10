//
//  ViewController.swift
//  Core Data
//
//  Created by Tiago Hermano on 2/22/17.
//  Copyright © 2017 Tiago Hermano. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurações iniciais para utitlizar o Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // gerenciador de persistencia de dados utilizando o Core Data
        let context = appDelegate.persistentContainer.viewContext
        
        let produto = NSEntityDescription.insertNewObject(forEntityName: "Produtos", into: context)
        /*
        
        
        // Configurar objeto
        produto.setValue("Ovos", forKey: "nome")
        produto.setValue("descicao 3", forKey: "descricao")
        produto.setValue("Vermelho", forKey: "cor")
        produto.setValue(8.40, forKey: "preco")
        
        // Salvar valores no contexto(Requer uso do bloco: Try/Catch)
        do {
            try context.save()
            print("Dados salvos com sucesso!")
        } catch {
            print("Erro ao salvar os dados")
        }
        */
        
        //    Recuperar dados utilizando Core Data
 
        
        
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Produtos")
        
        //  Ordenar de A-Z
        let ordenacaoAZ = NSSortDescriptor(key: "nome", ascending: true)
        
        //  Ordenar de Z-A
        // let ordenacaoZA = NSSortDescriptor(key: "preco", ascending: false)
        
        //  Consultas no Banco de Dados
        //let predicate = NSPredicate(format: "nome == %@", "Requeijão")
        //let predicate = NSPredicate(format: "cor contains %@", "osa")
        //let predicate = NSPredicate(format: "cor contains [c] %@", "rosa")
        //let predicate = NSPredicate(format: "nome beginswith [c] %@", "Le")
        let filtroPreco = NSPredicate(format: "preco <= @%", "4.0")
        //let filtroNome = NSPredicate(format: "nome == @% ", "Manteiga")
        
        //  Combinando consultas
        //let combinacaoFiltros = NSCompoundPredicate(andPredicateWithSubpredicates: [filtroPreco, filtroNome])
        //let combinacaoFiltros = NSCompoundPredicate(orPredicateWithSubpredicates: filtroPreco, filtroNome)
        
        // Aplicar filtros e consultas
        requisicao.sortDescriptors = [ordenacaoAZ]
        requisicao.predicate = filtroPreco
        
        do {
            let produtos = try context.fetch(requisicao)
            if produtos.count > 0 {
                for produto in produtos as! [NSManagedObject]{
                    
                    // Atualizar itens
                    //(produto as AnyObject).setValue("Requeijão", forKey: "nome")
                    //(produto as AnyObject).setValue(5.0, forKey: "preco")
                    
                    /*
                    do{
                        try context.save()
                        print("Dados salvos com sucesso")
                    } catch {
                        print("Não foi possível salvar o novo valor")
                    }
                    */
                    
                    // Deletar itens
                    context.delete(produto)
                    do{
                        try context.save()
                        print("Item removido com sucesso")
                    } catch {
                        print("Não foi possível remover item")
                    }
                    
                    // Recuperar itens
                    let nomeProduto = (produto as AnyObject).value(forKey: "nome")
                    let precoProduto = (produto as AnyObject).value(forKey: "preco")
                    
                    print(String(describing: nomeProduto) + " - " + String(describing: precoProduto))
                }
            } else {
                print("Nenhum produto encontrado")
            }
            
            print("Sucesso ao recuperar os produtos")
        } catch {
            print("Erro ao recuperar os produtos")
        }
        
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

