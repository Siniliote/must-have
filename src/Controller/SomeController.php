<?php

namespace App\Controller;

use Knp\Bundle\SnappyBundle\Snappy\Response\PdfResponse;
use Knp\Snappy\Pdf;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\UX\Chartjs\Builder\ChartBuilderInterface;

class SomeController extends AbstractController
{
    #[Route('/pdf', name: 'pdf')]
    public function pdfAction(Pdf $knpSnappyPdf, ChartBuilderInterface $chartBuilder): Response
    {

        $html = $this->renderView('sample/index.html.twig');

        return new PdfResponse(
            $knpSnappyPdf->getOutputFromHtml($html, [
                'enable-local-file-access' => true,
                'debug-javascript' => true,
                'javascript-delay'=> 15000
            ]),
            'file.pdf'
        );
    }
}
