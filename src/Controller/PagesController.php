<?php
declare(strict_types=1);

namespace App\Controller;

use App\Form\ContactType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\UX\Turbo\Stream\TurboStreamResponse;

final class PagesController extends AbstractController
{
    #[Route('/home_produit', name: 'app_homepage')]
    public function home(): Response
    {
        return $this->render('pages/home.html.twig');
    }

    #[Route('/produits', name: 'app_produits')]
    public function products(): Response
    {
        $products = [];

        for ($i = 1; $i <= 5; $i++) {
            $products[] = [
                'title' => "Produit $i",
            ];
        }

        return $this->render('pages/produits/list.html.twig', [
            'products' => $products,
        ]);
    }

    #[Route('/contact', name: 'app_contact')]
    public function contact(Request $request): Response
    {
        $form = $this->createForm(ContactType::class);
        $blankForm = clone $form;
        $form->handleRequest($request);
        
        if ($form->isSubmitted() && $form->isValid()) {
            $contactName = $form->get('name')->getData();
        
            if (TurboStreamResponse::STREAM_FORMAT === $request->getPreferredFormat()) {
                return $this->render('pages/contact/success.stream.html.twig', [
                    'contactName' => $contactName,
                    'contactForm' => $blankForm->createView(),
                ], new TurboStreamResponse());
            }
        
            // Si le client ne supporte pas ou n'accepte pas l'utilisation de JavaScript, l'application doit continuer de fonctionner.
            // Ici, on rajoute un flash message ainsi qu'une redirection classique.
        
            $this->addFlash('success', "Merci pour votre message $contactName !");
        
            return $this->redirectToRoute('app_contact', [], Response::HTTP_SEE_OTHER);
        }
        
        return $this->render('pages/contact/index.html.twig', [
            'contactForm' => $form->createView(),
        ]);
    }
}