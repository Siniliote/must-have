<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HighchartsController extends AbstractController
{
    #[Route('/highcharts', name: 'highcharts')]
    public function index(): Response
    {
        return $this->render('highcharts/index.html.twig', [
            'controller_name' => 'HighchartsController',
        ]);
    }
}
