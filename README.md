## Descripción de proyecto ##
Wishlist es un sencillo proyecto el cual hace mucho tenia en mente, y aprovecho esta oportunidad para desarrollar un MVP de lo que podría llegar a ser su idea en su totalidad.

*Arquitectura:*
Se seleccionó MVP (Model-View-Presenter) como el patrón de diseño de arquitectura a usar puesto que es una idea reducida que no necesita una separación de responsabilidades superior a la propuesta por este patrón.

*5. Networking Approach*
Se incluyó dentro de las dependencias y dentro del control de código fuente la famosa y bien conocida Alamofire, la cual está basada en AFNetworking para facilitar el consumo de REST Web Services.

De igual manera se incluyo un protocolo común de consumo de datos persistidos (WishesDataStoreProtocol) el cual puede servir para propositos de pruebas unitarias y el uso de diferentes fuentes de persistencia de datos, mediante la abstracción de los métodos de consumo (lectura, inserción, etc).

Adicionalmente se dejó una implementación de WishesDataStoreProtocol conocida como NetworkWishesDataStore la cual representa de manera precisa el consumo de un posible Web Service existente y que se debe sencillamente utilizar en el WishesDataManager tal cual como se hizó con sus hermanos de implementación Mocked y Local.

*6. Handling huge amounts of records*
Visualmente, el componente incluido en UIKit: UITableView, el cual utilicé para mostrar y representar la lista cuenta con la característica de reutilizar los componentes visuales usados para cada item (celdas).

Funcionalmente, todo el trabajo que podría implicar un impacto en el performance de la aplicación es delegado a los datastores de manera que ellos, sean bases de datos locales, web services o cualquier otro medio se responsabilicen tanto de la búsqueda (filtro por nombre) y ordenamiento (alfabetico por nombre).
