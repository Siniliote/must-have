<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class Swup1Controller extends AbstractController
{
    #[Route('/swup1', name: 'swup1')]
    public function index(): Response
    {
        return $this->render('swup1/index.html.twig', [
            'controller_name' => 'Swup1Controller',
        ]);
    }
}
