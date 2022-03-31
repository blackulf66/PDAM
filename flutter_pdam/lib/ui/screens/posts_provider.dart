

import 'post_model.dart';

class PostProvider{

  List<Post> posts = <Post>[];
  List<Post> getPosts(){

    posts = [
      new Post(
        userName: "SibylWalker",
        userPhoto: "https://icones.pro/wp-content/uploads/2021/04/icone-cercle-rempli-noir.png",
        caption: "Suscipit sit dolores asperiores quia. Commodi nostrum sit ipsam voluptate corporis ipsa nisi ut. Vel tempora eos cumque sint maxime exercitationem. Ratione dolore rerum placeat repellat ad deserunt mollitia in. Provident at voluptas minima qui voluptas. Pariatur dolores perferendis earum voluptatem eius assumenda quam.",
        postPhoto: "https://ep01.epimg.net/elpais/imagenes/2019/10/30/album/1572424649_614672_1572453030_noticia_normal.jpg",
        date: "July 1",
        likes: 1180,
        comentarios: 2000,
        topsLikes: ["Jennifer","Sigmund"]
      ),
       new Post(
        userName: "ChelseaSkiles",
        userPhoto: "https://icones.pro/wp-content/uploads/2021/04/icone-cercle-rempli-noir.png",
        caption: "Repellat laborum sit id.",
        postPhoto: "https://cdn.pocket-lint.com/r/s/1200x/assets/images/151737-games-feature-batman-games-in-order-how-to-play-the-arkham-series-and-more-image1-m8vygjidfb.jpg",
        date: "July 2",
        likes: 150,
        comentarios: 1000,
        topsLikes: ["Wyman","Mozelle"]
      ),
      new Post(
        userName: "PaxtonKautzer",
        userPhoto: "https://icones.pro/wp-content/uploads/2021/04/icone-cercle-rempli-noir.png",
        caption: "Est dolor sit in tempore perferendis qui tenetur est voluptas. Qui qui repudiandae. Repellat aut suscipit velit dolorum voluptas aut sit. Magni illum non ut quis est quibusdam. Consequuntur et consequatur est nesciunt.",
        postPhoto: "https://pics.filmaffinity.com/Spider_Man_No_Way_Home-642739124-large.jpg",
        date: "July 4",
        likes: 252,
        comentarios: 4000,
        topsLikes: ["Braulio","Dawn"]
      ),
      new Post(
        userName: "KaitlynMacejkovic",
        userPhoto: "https://icones.pro/wp-content/uploads/2021/04/icone-cercle-rempli-noir.png",
        caption: "Dolores aspernatur labore reprehenderit dolorem magni est tenetur. Necessitatibus enim sunt nemo laborum. Aut repellat ad ea pariatur eos. Quo aliquam eos minus aut eum rerum veritatis voluptas.",
        postPhoto: "https://i0.wp.com/hipertextual.com/wp-content/uploads/2021/09/spider-man-2-scaled.jpg?fit=1200%2C755&ssl=1",
        date: "July 7",
        likes: 856,
        comentarios: 52000,
        topsLikes: ["Koby","Evan"]
      ),
      new Post(
        userName: "HoracioMarks",
        userPhoto: "https://icones.pro/wp-content/uploads/2021/04/icone-cercle-rempli-noir.png",
        caption: "Inventore maiores eaque rerum debitis accusantium.",
        postPhoto: "https://pm1.narvii.com/7951/7c96680293d0d5a69fb930b520891ce641f22364r1-844-1055v2_hq.jpg",
        date: "July 7",
        likes: 506,
        comentarios: 666,
        topsLikes: ["Constance","Euna"]
      ),
      new Post(
        userName: "MittieStrosin",
        userPhoto: "https://icones.pro/wp-content/uploads/2021/04/icone-cercle-rempli-noir.png",
        caption: "Et eaque enim est voluptas omnis quo totam perferendis hic.",
        postPhoto: "https://wallpaperaccess.com/full/3706815.jpg",
        date: "July 2",
        likes: 1523,
        comentarios: 777,
        topsLikes: ["Constantin","Sheridan"]
      ),
      new Post(
        userName: "StephanieSpinka",
        userPhoto: "https://icones.pro/wp-content/uploads/2021/04/icone-cercle-rempli-noir.png",
        caption: "Officia est dolor est aut autem quia.",
        postPhoto: "https://preview.redd.it/t8yuzzjq3gh81.jpg?width=640&crop=smart&auto=webp&s=b5b5abbeec76211b55234d33d30e8dcefe217dff",
        date: "July 5",
        likes: 856,
        comentarios: 0,
        topsLikes: ["Deontae","Eulalia"]
      )      
    ];
   
   return posts;

  }

}